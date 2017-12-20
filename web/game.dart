library game;

import 'dart:html';
import 'dart:web_gl';
import 'dart:async';
import 'dart:typed_data';
import 'dart:math';

import 'keyboard_handler.dart';

// game objects
part 'game_objects/game_object.dart';
part 'game_objects/root_object.dart';

part 'game_objects/player.dart';

part 'game_objects/pyramid.dart';

// math
part 'matrix4.dart';

// other
part 'gl_program.dart';

CanvasElement canvas;
RenderingContext gl;
GlProgram program;

Matrix4 pMatrix;
Matrix4 mvMatrix;
List<Matrix4> mvStack = new List<Matrix4>();

int attributePointerVertex;
int attributePointerColor;

KeyboardHandler keyboardHandler;

Game game;

void initGame() {
  canvas = querySelector("#canvas");
  gl = canvas.getContext3d();

  mvMatrix = new Matrix4()..identity();

  // inits input
  keyboardHandler = new KeyboardHandler(window);

  game = new Game();
  game.startGame();
}

mvPushMatrix() => mvStack.add(new Matrix4.fromMatrix(mvMatrix));

mvPopMatrix() => mvMatrix = mvStack.removeLast();

setMatrixUniforms() {
  gl.uniformMatrix4fv(program.uniforms['uPMatrix'], false, pMatrix.buf);
  gl.uniformMatrix4fv(program.uniforms['uMVMatrix'], false, mvMatrix.buf);
}

//------------------------------------------------------------------------------------------

class Game {
  Timer _timer;

  RootObject rootObject;

  Game() {
    program = new GlProgram(
        '''
          precision mediump float;

          varying vec4 vColor;

          void main(void) {
            gl_FragColor = vColor;
          }
        ''',
        '''
          attribute vec3 aVertexPosition;
          attribute vec4 aVertexColor;

          uniform mat4 uMVMatrix;
          uniform mat4 uPMatrix;

          varying vec4 vColor;

          void main(void) {
              gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
              vColor = aVertexColor;
          }
        ''',
        ['aVertexPosition', 'aVertexColor'],
        ['uMVMatrix', 'uPMatrix'],
        gl);
    gl.useProgram(program.program);

    gl.clearColor(0.0, 0.0, 0.0, 1.0);

    attributePointerVertex = program.attributes['aVertexPosition'];
    attributePointerColor = program.attributes['aVertexColor'];

    //inits root object
    rootObject = new RootObject();

    // Player pyramid = new Player();
    // pyramid.translateZ(-10.0);
    Player player = new Player();
    player.translateZ(-10.0);

    rootObject.addChild(player);
  }

  void _drawScene() {
    gl.viewport(0, 0, canvas.width, canvas.height);
    gl.clear(COLOR_BUFFER_BIT | DEPTH_BUFFER_BIT);
    gl.enable(DEPTH_TEST);
    gl.disable(BLEND);

    pMatrix =
        Matrix4.perspective(45.0, canvas.width / canvas.height, 0.1, 100.0);

    rootObject.draw();
  }

  void _handleUserInput(){
    rootObject.handleUserInputCall();
  }

  void startGame() {
    _timer = new Timer.periodic(
      new Duration(milliseconds: 15),
      (_) {
        _handleUserInput();
        _drawScene();
      },
    );
  }
}

library game;

import 'dart:html';
import 'dart:web_gl';
import 'dart:async';
import 'dart:typed_data';
import 'dart:math';

// import shaders
import 'shaders/fragment_shader.dart' as fragment_shader;
import 'shaders/vertex_shader.dart' as vertex_shader;

//
import 'input_handler.dart';

// game objects
part 'game_objects/game_object.dart';
part 'game_objects/root_object.dart';

part 'game_objects/player/player.dart';

part 'game_objects/pyramid.dart';

// math
part 'matrix4.dart';

CanvasElement canvas;
RenderingContext gl;

Game game;

void initGame() {
  canvas = querySelector("#canvas");
  gl = canvas.getContext3d();

  game = new Game();
  game.startGame();
}

// Global ------------------------------------------------------------------------------------
int get _attributePointerVertex => game._attributePointerVertex;

int get _attributePointerColor => game._attributePointerColor;

Matrix4 get pMatrix => game._pMatrix;

Matrix4 get mvMatrix => game._mvMatrix;

mvPushMatrix() => game.mvPushMatrix();

mvPopMatrix() => game.mvPopMatrix();

setMatrixUniforms() => game.setMatrixUniforms();

InputHandler get inputHandler => game._inputHandler;

//------------------------------------------------------------------------------------------

class Game {
  Matrix4 _pMatrix;
  Matrix4 _mvMatrix;
  List<Matrix4> _mvStack;

  Program _program;

  int _attributePointerVertex;
  int _attributePointerColor;

  UniformLocation _uniformLocationPMatrix;
  UniformLocation _uniformLocationMVMatrix;

  InputHandler _inputHandler;

  Timer _timer;

  // game objects
  RootObject rootObject;

  Game() {
    // inits Matrix-es
    _mvMatrix = new Matrix4()..identity();
    _mvStack = new List<Matrix4>();

    // inits Fragment Shader
    Shader fragmentShader = gl.createShader(FRAGMENT_SHADER);
    gl.shaderSource(fragmentShader, fragment_shader.source_code);
    gl.compileShader(fragmentShader);

    // inits Vertex Shader
    Shader vertexShader = gl.createShader(VERTEX_SHADER);
    gl.shaderSource(vertexShader, vertex_shader.source_code);
    gl.compileShader(vertexShader);

    // attaches shaders
    _program = gl.createProgram();
    gl.attachShader(_program, vertexShader);
    gl.attachShader(_program, fragmentShader);
    gl.linkProgram(_program);
    gl.useProgram(_program);

    if (!gl.getProgramParameter(_program, LINK_STATUS)) {
      window.alert("Could not init shaders.");
    }

    // sets attribute pointers
    _attributePointerVertex =
        gl.getAttribLocation(_program, vertex_shader.attribute_neme_vertexPosition);
    gl.enableVertexAttribArray(_attributePointerVertex);

    _attributePointerColor =
        gl.getAttribLocation(_program, vertex_shader.attribute_name_vertexColor);
    gl.enableVertexAttribArray(_attributePointerColor);

    // sets uniform Locations
    _uniformLocationMVMatrix =
        gl.getUniformLocation(_program, vertex_shader.uniform_name_mvMatrix);
    _uniformLocationPMatrix =
        gl.getUniformLocation(_program, vertex_shader.uniform_name_pMatrix);

    gl.clearColor(0.0, 0.0, 0.0, 1.0);

    // inits inputHandler
    _inputHandler = new InputHandler(window);

    //inits root object
    rootObject = new RootObject();

    // Player pyramid = new Player();
    // pyramid.translateZ(-10.0);
    Player player = new Player();
    player.z = -10.0;

    rootObject.addChild(player);
  }

  void mvPushMatrix() {
    _mvStack.add(new Matrix4.fromMatrix(_mvMatrix));
  }

  void mvPopMatrix() {
    _mvMatrix = _mvStack.removeLast();
  }

  void setMatrixUniforms() {
    gl.uniformMatrix4fv(_uniformLocationPMatrix, false, _pMatrix.buf);
    gl.uniformMatrix4fv(_uniformLocationMVMatrix, false, _mvMatrix.buf);
  }

  void _drawScene() {
    gl.viewport(0, 0, canvas.width, canvas.height);
    gl.clear(COLOR_BUFFER_BIT | DEPTH_BUFFER_BIT);
    gl.enable(DEPTH_TEST);
    gl.disable(BLEND);

    _pMatrix =
        Matrix4.perspective(45.0, canvas.width / canvas.height, 0.1, 100.0);

    rootObject.draw();
  }

  void _handleUserInput() {
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

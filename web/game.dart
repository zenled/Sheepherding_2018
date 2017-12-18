import 'dart:html';
import 'dart:web_gl' as web_gl;
import 'dart:async';

import 'gl_program.dart';
import 'matrix4.dart';
import 'keyboard_handler.dart';
import 'shaders/fragment_shader.dart';
import 'shaders/vertex_shader.dart';
import 'game_objects/example_implementation.dart';
import 'game_objects/main_camera.dart';
import 'game_objects/game_object_stuff.dart' as game_object_stuff;

class Game {
  CanvasElement _canvas;
  web_gl.RenderingContext _gl;
  //web_gl.Program _program;
  GlProgram _program;

  //web_gl.Shader _vertex_shader;

  KeyboardHandler _keyboardHandler;
  Timer _timer;

  Matrix4 pMatrix;
  Camera camera;

  Matrix4 mvMatrix;
  List<Matrix4> mvStack = <Matrix4>[];

  ExampleImplementation ei0;
  ExampleImplementation ei1;
  ExampleImplementation ei2;

  Game() {
    _canvas = querySelector("#canvas");
    _gl = _canvas.getContext3d();

    // inits shaders
    //_program = _gl.createProgram();
    // _program = new GlProgram(
    //   fraggment_shader_source,
    //   vertex_shader_source,
    //   ['aVertexPosition', 'aVertexColor'],
    //   ['uMVMatrix', 'uPMatrix'],
    //   _gl,
    // );
    _program = new GlProgram(
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
        _gl);
    _gl.useProgram(_program.program);

    // String vertexShaderSource = vertex_shader_source;
    // _vertex_shader = _gl.createShader(web_gl.VERTEX_SHADER);
    // _gl.shaderSource(_vertex_shader, vertexShaderSource);
    // _gl.compileShader(_vertex_shader);
    // _gl.useProgram(_program);

    _gl.clearColor(0.0, 0.0, 0.0, 1.0);

    mvMatrix = new Matrix4()..identity();

    game_object_stuff.gl = _gl;
    game_object_stuff.setUniforms = setMatrixUniforms;
    game_object_stuff.attributePointer_vertex =
        _program.attributes['aVertexPosition'];
    game_object_stuff.attributePointer_color =
        _program.attributes['aVertexColor'];
    game_object_stuff.mvMatrix = mvMatrix;

    // sets up key handling
    _keyboardHandler = new KeyboardHandler(window);

    ei0 = new ExampleImplementation();
    //ei0.moveZ(-10.0);
    ei1 = new ExampleImplementation();
    //ei1.moveZ(-10.0);
    //ei1.moveY(2.0);
    ei2 = new ExampleImplementation();
    //ei2.moveZ(-12.0);
    ei2.z = -10.0;
    ei2.x = 10.0;

        // sets camera
    camera = new Camera(_canvas.width / _canvas.height, ei0);
  }

  void mvPushMatrix() => mvStack.add(new Matrix4.fromMatrix(mvMatrix));

  void mvPopMatrix() => mvMatrix = mvStack.removeLast();

  void _drawScene() {
    _gl.viewport(0, 0, _canvas.width, _canvas.height);
    _gl.clear(web_gl.COLOR_BUFFER_BIT | web_gl.DEPTH_BUFFER_BIT);
    _gl.enable(web_gl.DEPTH_TEST);
    _gl.disable(web_gl.BLEND);

    // pMatrix =
    //     Matrix4.perspective(45.0, _canvas.width / _canvas.height, 0.1, 100.0);
    pMatrix = camera.getPMatrix();

    //pMatrix.translate([0.0, 0.0,10.0]);
    // pMatrix.translate([0.0,-3.0,5.0]);
    // pMatrix.rotateX(0.1);
    // pMatrix.rotateY(-0.1);

    //------------------------

    // mvMatrix = new Matrix4()..identity();
    // mvMatrix.translate([0.0,0.0,-15.0]);
    ei0.draw();
    //ei0.moveX(-0.01);

    ei1.draw();
    ei2.draw();
    // ei1.moveX(0.01);
  }

  setMatrixUniforms() {
    _gl.uniformMatrix4fv(_program.uniforms['uPMatrix'], false, pMatrix.buf);
    _gl.uniformMatrix4fv(_program.uniforms['uMVMatrix'], false, mvMatrix.buf);
  }

  void _handleUserInput(){
    if (_keyboardHandler.isPressingLEFT){
      ei0.moveX(-0.2);
      //camera.moveX(-0.2);
    }
    if(_keyboardHandler.isPressingRIGHT){
      ei0.moveX(0.2);
      //camera.moveX(0.2);
    }
    if (_keyboardHandler.isPressingFORWARD){
      ei0.moveZ(-0.2);
      //camera.moveZ(-0.2);
    }
    if (_keyboardHandler.isPressingBACKWARD){
      ei0.moveZ(0.2);
      //camera.moveZ(0.2);
    }
    if (_keyboardHandler.isPressingUP){
      ei0.moveY(0.2);
    }
    if (_keyboardHandler.isPressingDOWN){
      ei0.moveY(-0.2);
    }
    if (_keyboardHandler.isPressingROTATE_LEFT){
      ei0.rotateY(0.02);
      //camera.rotateY(0.01);
    }
    if (_keyboardHandler.isPressingROTATE_RIGHT){
        ei0.rotateY(-0.02);
      //camera.rotateY(-0.01);
    }
    //camera.rotateY(_keyboardHandler.getMouseMoveX() * -0.002);
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

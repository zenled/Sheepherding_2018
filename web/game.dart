import 'dart:html';
import 'dart:web_gl';
import 'dart:async';

// import shaders
import 'shaders/fragment_shader.dart' as fragment_shader;
import 'shaders/vertex_shader.dart' as vertex_shader;

// import other stuff
import 'global.dart';
import 'matrix4.dart';
import 'input_handler.dart';

import 'game_objects/root_object.dart';
import 'game_objects/player/player.dart';
import 'game_objects/main_camera.dart';
import 'game_objects/pyramid.dart';

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
  MainCamera mainCamera;
  Player player;

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
    _attributePointerVertex = gl.getAttribLocation(
        _program, vertex_shader.attribute_neme_vertexPosition);
    gl.enableVertexAttribArray(_attributePointerVertex);

    _attributePointerColor = gl.getAttribLocation(
        _program, vertex_shader.attribute_name_vertexColor);
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
    player = new Player();
    player.z = -10.0;

    mainCamera = new MainCamera(player);

    Pyramid pyramid = new Pyramid();
    pyramid.translateZ(-20.0);
    pyramid.translateX(5.0);
    rootObject.addChild(pyramid);

    Pyramid pyramid1 = new Pyramid();
    pyramid1.translateZ(-20.0);
    pyramid1.translateX(-5.0);
    rootObject.addChild(pyramid1);

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

    mainCamera.updatePMatrix();

    rootObject.draw();
  }

  void _handleUserInput() {
    rootObject.handleUserInputCall();
  }

  void startGame() {
    window.animationFrame.then(_tick);
    // _timer = new Timer.periodic(
    //   new Duration(milliseconds: 15),
    //   (_) {
    //     _handleUserInput();
    //     _drawScene();
    //   },
    // );
  }

  void _tick(_) {
    window.animationFrame.then(_tick);
    _handleUserInput();
    _drawScene();
  }

  int get attributePointerVertex => _attributePointerVertex;

  int get attributePointerColor => _attributePointerColor;

  Matrix4 get pMatrix => _pMatrix;

  void set pMatrix(Matrix4 value) => _pMatrix = value;

  Matrix4 get mvMatrix => _mvMatrix;

  InputHandler get inputHandler => _inputHandler;
}

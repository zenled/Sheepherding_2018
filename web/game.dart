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
import 'math_util.dart' as math_util;

// Game Objects
import 'game_objects/root_object.dart';
import 'game_objects/player/player.dart';
import 'game_objects/main_camera.dart';
import 'game_objects/pyramid.dart';
import 'game_objects/world/world.dart';
import 'game_objects/world/lake.dart';

// Controllers
import 'controllers/herd_controller.dart';
import 'controllers/lake_controller.dart';
import 'controllers/grass_controller.dart';
import 'controllers/dirt_controller.dart';

class Game {
  Matrix4 _pMatrix;
  Matrix4 _mvMatrix;
  List<Matrix4> _mvStack;

  Program _program;

  int _attributePointerVertex;
  int _attributePointerColor;
  int _attributePointerTextureCoord;

  UniformLocation _uniformLocationPMatrix;
  UniformLocation _uniformLocationMVMatrix;
  UniformLocation _uniformLocationSampler;

  InputHandler _inputHandler;

  Timer _timer;

  // game objects
  RootObject rootObject;
  MainCamera mainCamera;
  Player player;

  // Controllers
  HerdController herdController;
  LakeController lakeController;
  GrassController grassConroller;
  DirtController dirtController;

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

    _attributePointerTextureCoord = gl.getAttribLocation(
        _program, vertex_shader.attribute_name_textureCoord);
    gl.enableVertexAttribArray(_attributePointerTextureCoord);

    // sets uniform Locations
    _uniformLocationMVMatrix =
        gl.getUniformLocation(_program, vertex_shader.uniform_name_mvMatrix);
    _uniformLocationPMatrix =
        gl.getUniformLocation(_program, vertex_shader.uniform_name_pMatrix);
    _uniformLocationSampler =
        gl.getUniformLocation(_program, vertex_shader.uniform_name_sampler);

    gl.clearColor(0.0, 0.0, 0.0, 1.0);

    // inits inputHandler
    _inputHandler = new InputHandler(window);

    // inits Game Objects ----------------------------------------------------------------------
    // rootObject
    rootObject = new RootObject();

    // world (scenery)
    World world = new World();
    rootObject.addChild(world);

    // player
    player = new Player();
    rootObject.addChild(player);

    // mainCamera
    mainCamera = new MainCamera(player);

    // inits Controllers ----------------------------------------------------------------------
    herdController = new HerdController(rootObject, player);
    lakeController = new LakeController(rootObject);
    grassConroller = new GrassController(rootObject);
    dirtController = new DirtController(rootObject);
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

    // Lake lake = lakeController.lakes.first;
    // for (math_util.Triangle triangle in lake.getCollisionDetectionTriangles()) {
    //   bool collision = math_util.isPointInTriangle(
    //       new math_util.Point2D(player.x, player.z), triangle);
    //   if (collision){
    //     print("Collision");
    //   }
    // }
  }

  void _handleUserInput() {
    mainCamera.handleUserInput();
    rootObject.handleUserInputCall();
  }

  void _handleControllers() {
    herdController.moveHerdMembers();
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
    _handleControllers();
    _drawScene();
  }

  int get attributePointerVertex => _attributePointerVertex;

  int get attributePointerColor => _attributePointerColor;

  int get attributePointerTextureCoord => _attributePointerTextureCoord;

  UniformLocation get uniformLocationSampler => _uniformLocationSampler;

  Matrix4 get pMatrix => _pMatrix;

  void set pMatrix(Matrix4 value) => _pMatrix = value;

  Matrix4 get mvMatrix => _mvMatrix;

  InputHandler get inputHandler => _inputHandler;
}

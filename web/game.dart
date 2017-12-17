import 'dart:html';
import 'dart:web_gl' as web_gl;

import 'gl_program.dart';
import 'matrix4.dart';
import 'shaders/fragment_shader.dart';
import 'shaders/vertex_shader.dart';
import 'game_objects/player.dart';

class Game {
  CanvasElement _canvas;
  web_gl.RenderingContext _gl;
  //web_gl.Program _program;
  GlProgram _program;

  //web_gl.Shader _vertex_shader;

  Matrix4 pMatrix;

  Matrix4 mvMatrix;
  List<Matrix4> mvStack = <Matrix4>[];

  Player player;

  Game() {
    _canvas = querySelector("#canvas");
    _gl = _canvas.getContext3d();

    // inits shaders
    //_program = _gl.createProgram();
    _program = new GlProgram(
      fraggment_shader_source,
      vertex_shader_source,
      ['aVertexPosition', 'aVertexColor'],
      ['uMVMatrix', 'uPMatrix'],
      _gl,
    );
    _gl.useProgram(_program.program);

    // String vertexShaderSource = vertex_shader_source;
    // _vertex_shader = _gl.createShader(web_gl.VERTEX_SHADER);
    // _gl.shaderSource(_vertex_shader, vertexShaderSource);
    // _gl.compileShader(_vertex_shader);
    // _gl.useProgram(_program);

    _gl.clearColor(0.0, 0.0, 0.0, 1.0);

    mvMatrix = new Matrix4()..identity();

    player = new Player(_gl);
  }

  void mvPushMatrix() => mvStack.add(new Matrix4.fromMatrix(mvMatrix));

  void mvPopMatrix() => mvMatrix = mvStack.removeLast();

  void drawScene() {
    _gl.viewport(0, 0, _canvas.width, _canvas.height);
    _gl.clear(web_gl.COLOR_BUFFER_BIT | web_gl.DEPTH_BUFFER_BIT);
    _gl.enable(web_gl.DEPTH_TEST);
    _gl.disable(web_gl.BLEND);

    pMatrix =
        Matrix4.perspective(45.0, _canvas.width / _canvas.height, 0.1, 100.0);

    //------------------------
    mvPushMatrix();

    mvMatrix.translate(<double>[-1.5, 0.0, 7.0]);

    mvPushMatrix();
    player.draw(
      setUniforms: setMatrixUniforms(),
      vertex: _program.attributes['aVertexPosition'],
      color: _program.attributes['aVertexColor'],
    );

    mvPopMatrix();
  }

  setMatrixUniforms() {
    _gl.uniformMatrix4fv(_program.uniforms['uPMatrix'], false, pMatrix.buf);
    _gl.uniformMatrix4fv(_program.uniforms['uMVMatrix'], false, mvMatrix.buf);
  }
}

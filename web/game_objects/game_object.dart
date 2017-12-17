import 'dart:typed_data';
import 'dart:web_gl' as web_gl;

import 'package:meta/meta.dart';

abstract class GameObject {
  web_gl.RenderingContext _gl;

  web_gl.Buffer _vertexPositionBuffer;
  int _numOfVertices;
  web_gl.Buffer _vertexColorBuffer;

  double x;
  double y;
  double z; 

  GameObject(this._gl);

  void setVertices(List<double> vertices) {
    _numOfVertices = vertices.length;
    _vertexPositionBuffer = _gl.createBuffer();
    _gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexPositionBuffer);
    _gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(vertices),
      web_gl.STATIC_DRAW,
    );
  }

  void setColors(List<double> colors) {
    _vertexColorBuffer = _gl.createBuffer();
    _gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexColorBuffer);
    _gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(colors),
      web_gl.STATIC_DRAW,
    );
  }

  void draw({int vertex, int normal, int coord, int color, setUniforms()}) {
    if (vertex != null) {
      _gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexPositionBuffer);
      _gl.vertexAttribPointer(vertex, 3, web_gl.FLOAT, false, 0, 0);
    }

    // if (normal != null) {
    //   _gl.bindBuffer(ARRAY_BUFFER, normalBuffer);
    //   gl.vertexAttribPointer(normal, 3, FLOAT, false, 0, 0);
    // }

    // if (coord != null) {
    //   gl.bindBuffer(ARRAY_BUFFER, textureCoordBuffer);
    //   gl.vertexAttribPointer(coord, 2, FLOAT, false, 0, 0);
    // }

    if (color != null) {
      _gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexColorBuffer);
      _gl.vertexAttribPointer(color, 4, web_gl.FLOAT, false, 0, 0);
    }

    if (setUniforms != null) setUniforms();
    _gl.drawArrays(web_gl.TRIANGLES, 0, _numOfVertices);
  }
}

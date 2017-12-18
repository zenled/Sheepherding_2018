import 'dart:web_gl' as web_gl;
import 'dart:typed_data';

import 'game_object_stuff.dart';

class GameObject {
  int _numOfVerticies;
  web_gl.Buffer _vertexPositionBuffer;
  web_gl.Buffer _vertexNormalBuffer;
  web_gl.Buffer _textureCoordinateBuffer;
  web_gl.Buffer _vertexColorBuffer;

  void setVerticies(List<double> vertices) {
    _numOfVerticies = vertices.length ~/ 3;

    _vertexPositionBuffer = gl.createBuffer();
    gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexPositionBuffer);
    gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(vertices),
      web_gl.STATIC_DRAW,
    );
  }

  void setColors(List<double> colors) {
    _vertexColorBuffer = gl.createBuffer();
    gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexColorBuffer);
    gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(colors),
      web_gl.STATIC_DRAW,
    );
  }

  void setTextureCoordinates(List<double> normals) {
    _vertexNormalBuffer = gl.createBuffer();
    gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexNormalBuffer);
    gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(normals),
      web_gl.STATIC_DRAW,
    );
  }

  void setNormals(List<double> textureCoordinates) {
    _textureCoordinateBuffer = gl.createBuffer();
    gl.bindBuffer(web_gl.ARRAY_BUFFER, _textureCoordinateBuffer);
    gl.bufferData(
      web_gl.ARRAY_BUFFER,
      new Float32List.fromList(textureCoordinates),
      web_gl.STATIC_DRAW,
    );
  }

  void draw({int normal, int coord}) {
    if (_vertexPositionBuffer != null) {
      gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexPositionBuffer);
      gl.vertexAttribPointer(attributePointer_vertex, 3, web_gl.FLOAT, false, 0, 0);
    }

    if (normal != null) {
      gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexNormalBuffer);
      gl.vertexAttribPointer(normal, 3, web_gl.FLOAT, false, 0, 0);
    }

    if (coord != null) {
      gl.bindBuffer(web_gl.ARRAY_BUFFER, _textureCoordinateBuffer);
      gl.vertexAttribPointer(coord, 2, web_gl.FLOAT, false, 0, 0);
    }

    if (_vertexColorBuffer != null) {
      gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexColorBuffer);
      gl.vertexAttribPointer(attributePointer_color, 4, web_gl.FLOAT, false, 0, 0);
    }

    setUniforms();
    gl.drawArrays(web_gl.TRIANGLES, 0, _numOfVerticies);
  }
}

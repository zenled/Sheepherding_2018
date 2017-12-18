import 'dart:web_gl' as web_gl;
import 'dart:typed_data';

import 'game_object_stuff.dart';
import '../matrix4.dart';

class GameObject {
  int _numOfVerticies;
  web_gl.Buffer _vertexPositionBuffer;
  web_gl.Buffer _vertexNormalBuffer;
  web_gl.Buffer _textureCoordinateBuffer;
  web_gl.Buffer _vertexColorBuffer;

  double x;
  double y;
  double z;

  double rotationX;
  double rotationY;
  double rotationZ;

  GameObject() {
    x = 0.0;
    y = 0.0;
    z = 0.0;

    rotationX = 0.0;
    rotationY = 0.0;
    rotationZ = 0.0;
  }

  /// Changes x by [moveBy]
  void moveX(double moveBy) => x += moveBy;

  /// Changes y by [moveBy]
  void moveY(double moveBy) => y += moveBy;

  /// Changes z by [moveBy]
  void moveZ(double moveBy) => z += moveBy;

  /// Rotates on Y-axis by [rotateBy]
  void rotateY(double rotateBy) => rotationY += rotateBy;

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
    mvMatrix.identity();

    
    
    
    mvMatrix.rotateY(rotationY);
    mvMatrix.translate(<double>[x, y, z]);
    

    if (_vertexPositionBuffer != null) {
      gl.bindBuffer(web_gl.ARRAY_BUFFER, _vertexPositionBuffer);
      gl.vertexAttribPointer(
          attributePointer_vertex, 3, web_gl.FLOAT, false, 0, 0);
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
      gl.vertexAttribPointer(
          attributePointer_color, 4, web_gl.FLOAT, false, 0, 0);
    }

    setUniforms();
    gl.drawArrays(web_gl.TRIANGLES, 0, _numOfVerticies);
  }
}

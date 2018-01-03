import 'dart:html';
import 'dart:web_gl';
import 'dart:typed_data';

import '../global.dart' as global;
import '../matrix4.dart';
import '../math_util.dart' as math_util;

export 'game_object.dart';
export '../global.dart';
export '../input_handler.dart';
export '../matrix4.dart';

abstract class GameObject {
  Buffer vertexBuffer;
  Buffer normalBuffer;
  Buffer textureCoordBuffer;
  Buffer colorBuffer;

  int numOfVerticies;

  double x;
  double y;
  double z;

  double rotationX;
  double rotationY;
  double rotationZ;

  double scaleX;
  double scaleY;
  double scaleZ;

  String _textureSource;
  Texture texture;

  GameObject parent;
  Set<GameObject> _children = new Set<GameObject>();

  GameObject() {
    x = 0.0;
    y = 0.0;
    z = 0.0;

    rotationX = 0.0;
    rotationY = 0.0;
    rotationZ = 0.0;

    scaleX = 1.0;
    scaleY = 1.0;
    scaleZ = 1.0;
  }

  void translateX(double value) {
    Matrix4 matrix4 = new Matrix4()..identity();
    matrix4.rotateX(radians(rotationX));
    matrix4.rotateY(radians(rotationY));
    matrix4.rotateZ(radians(rotationZ));
    matrix4.translate(<double>[value, 0.0, 0.0]);

    x += matrix4.m03;
    y += matrix4.m13;
    z += matrix4.m23;
  }

  void translateY(double value) {
    Matrix4 matrix4 = new Matrix4()..identity();
    matrix4.rotateX(radians(rotationX));
    matrix4.rotateY(radians(rotationY));
    matrix4.rotateZ(radians(rotationZ));
    matrix4.translate(<double>[0.0, value, 0.0]);

    x += matrix4.m03;
    y += matrix4.m13;
    z += matrix4.m23;
  }

  void translateZ(double value) {
    Matrix4 matrix4 = new Matrix4()..identity();
    matrix4.rotateX(radians(rotationX));
    matrix4.rotateY(radians(rotationY));
    matrix4.rotateZ(radians(rotationZ));
    matrix4.translate([0.0, 0.0, value]);

    x += matrix4.m03;
    y += matrix4.m13;
    z += matrix4.m23;
  }

  void rotate({double x = 0.0, double y = 0.0, double z = 0.0}) {
    rotateX(x);
    rotateY(y);
    rotateZ(z);
  }

  void rotateX(double value) {
    rotationX += value;
    rotationX %= 360.0;
  }

  void rotateY(double value) {
    rotationY += value;
    rotationY %= 360.0;
  }

  void rotateZ(double value) {
    rotationZ += value;
    rotationZ %= 360.0;
  }

  Set<GameObject> get children => _children;

  void addChild(GameObject child) {
    _children.add(child);
  }

  void removeChild(GameObject childToRemove) {
    _children.remove(childToRemove);
  }

  void setVertexBuffer(List<double> vertices) {
    numOfVerticies = vertices.length ~/ 3;

    vertexBuffer = global.gl.createBuffer();
    global.gl.bindBuffer(ARRAY_BUFFER, vertexBuffer);
    global.gl.bufferData(
      ARRAY_BUFFER,
      new Float32List.fromList(vertices),
      STATIC_DRAW,
    );
  }

  void setColorBuffer(List<double> colors) {
    colorBuffer = global.gl.createBuffer();
    global.gl.bindBuffer(ARRAY_BUFFER, colorBuffer);
    global.gl.bufferData(
      ARRAY_BUFFER,
      new Float32List.fromList(colors),
      STATIC_DRAW,
    );
  }

  /// Sets texture
  ///
  /// example: setTexture("crate.gif")
  void setTexture(String textureUrl, List<double> textureCoordinates) {
    textureUrl = "textures/$textureUrl";
    _textureSource = textureUrl;

    global.loadTexture(textureUrl, (Texture texture, ImageElement element) {
      global.gl.bindTexture(TEXTURE_2D, texture);
      global.gl.pixelStorei(UNPACK_FLIP_Y_WEBGL, 1);
      global.gl.texImage2D(TEXTURE_2D, 0, RGBA, RGBA, UNSIGNED_BYTE, element);
      global.gl.texParameteri(TEXTURE_2D, TEXTURE_MAG_FILTER, NEAREST);
      global.gl.texParameteri(TEXTURE_2D, TEXTURE_MIN_FILTER, NEAREST);
      global.gl.bindTexture(TEXTURE_2D, null);
      this.texture = texture;
    }).then((_) {
      textureCoordBuffer = global.gl.createBuffer();
      global.gl.bindBuffer(ARRAY_BUFFER, textureCoordBuffer);
      global.gl.bufferData(
        ARRAY_BUFFER,
        new Float32List.fromList(textureCoordinates),
        STATIC_DRAW,
      );
    });
  }

  void handleUserInput() {}

  void handleUserInputCall() {
    handleUserInput();

    for (GameObject child in children) {
      child.handleUserInputCall();
    }
  }

  void draw() {
    global.mvPushMatrix();

    // translate
    global.mvMatrix.translate(<double>[x, y, z]);

    // rotate
    global.mvMatrix.rotateX(radians(rotationX));
    global.mvMatrix.rotateY(radians(rotationY));
    global.mvMatrix.rotateZ(radians(rotationZ));

    // scale
    global.mvMatrix.m00 *= scaleX;
    global.mvMatrix.m11 *= scaleY;
    global.mvMatrix.m22 *= scaleZ;

    // texture
    global.gl.activeTexture(TEXTURE0);
    global.gl.bindTexture(TEXTURE_2D, texture);
    global.gl.uniform1i(global.uSampler, 0);

    for (GameObject child in children) {
      child.draw();
    }

    if (vertexBuffer != null) {
      global.gl.bindBuffer(ARRAY_BUFFER, vertexBuffer);
      global.gl.vertexAttribPointer(
          global.attributePointerVertex, 3, FLOAT, false, 0, 0);
    }

    // if (normal != null) {
    //   gl.bindBuffer(ARRAY_BUFFER, normalBuffer);
    //   gl.vertexAttribPointer(normal, 3, FLOAT, false, 0, 0);
    // }

    if (textureCoordBuffer != null) {
      global.gl.bindBuffer(ARRAY_BUFFER, textureCoordBuffer);
      global.gl.vertexAttribPointer(
          global.attributePointerTextureCoord, 2, FLOAT, false, 0, 0);
    }

    if (colorBuffer != null) {
      global.gl.bindBuffer(ARRAY_BUFFER, colorBuffer);
      global.gl.vertexAttribPointer(
          global.attributePointerColor, 4, FLOAT, false, 0, 0);
    }

    global.setMatrixUniforms();
    global.gl.drawArrays(TRIANGLES, 0, numOfVerticies);

    global.mvPopMatrix();
  }

  math_util.Point3D get point3D => new math_util.Point3D(x, y, z);

  math_util.Point2D get point2D_birdView => new math_util.Point2D(x, -z);
}

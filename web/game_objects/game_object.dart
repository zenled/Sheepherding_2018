part of game;

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

  GameObject parent;
  Set<GameObject> _children = new Set<GameObject>();

  GameObject() {
    x = 0.0;
    y = 0.0;
    z = 0.0;

    rotationX = 0.0;
    rotationY = 0.0;
    rotationZ = 0.0;
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

    vertexBuffer = gl.createBuffer();
    gl.bindBuffer(ARRAY_BUFFER, vertexBuffer);
    gl.bufferData(
      ARRAY_BUFFER,
      new Float32List.fromList(vertices),
      STATIC_DRAW,
    );
  }

  void setColorBuffer(List<double> colors) {
    colorBuffer = gl.createBuffer();
    gl.bindBuffer(ARRAY_BUFFER, colorBuffer);
    gl.bufferData(
      ARRAY_BUFFER,
      new Float32List.fromList(colors),
      STATIC_DRAW,
    );
  }

  void handleUserInput() {}

  void handleUserInputCall() {
    handleUserInput();

    for (GameObject child in children) {
      child.handleUserInputCall();
    }
  }

  void draw() {
    mvPushMatrix();

    mvMatrix.translate(<double>[x, y, z]);

    mvMatrix.rotateX(radians(rotationX));
    mvMatrix.rotateY(radians(rotationY));
    mvMatrix.rotateZ(radians(rotationZ));

    for (GameObject child in children) {
      child.draw();
    }

    if (vertexBuffer != null) {
      gl.bindBuffer(ARRAY_BUFFER, vertexBuffer);
      gl.vertexAttribPointer(_attributePointerVertex, 3, FLOAT, false, 0, 0);
    }

    // if (normal != null) {
    //   gl.bindBuffer(ARRAY_BUFFER, normalBuffer);
    //   gl.vertexAttribPointer(normal, 3, FLOAT, false, 0, 0);
    // }

    // if (coord != null) {
    //   gl.bindBuffer(ARRAY_BUFFER, textureCoordBuffer);
    //   gl.vertexAttribPointer(coord, 2, FLOAT, false, 0, 0);
    // }

    if (colorBuffer != null) {
      gl.bindBuffer(ARRAY_BUFFER, colorBuffer);
      gl.vertexAttribPointer(_attributePointerColor, 4, FLOAT, false, 0, 0);
    }

    setMatrixUniforms();
    gl.drawArrays(TRIANGLES, 0, numOfVerticies);

    mvPopMatrix();
  }
}

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

  GameObject _parent;
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
    x += value;
  }

  void translateY(double value) {
    y += value;
  }

  void translateZ(double value) {
    z += value;
  }

  void rotateX(double value) {
    rotationX += value % 360.0;
  }

  void rotateY(double value) {
    rotationY += value % 360.0;
  }

  void rotateZ(double value) {
    rotationZ += value % 360.0;
  }

  GameObject get parent => _parent;
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
      gl.vertexAttribPointer(attributePointerVertex, 3, FLOAT, false, 0, 0);
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
      gl.vertexAttribPointer(attributePointerColor, 4, FLOAT, false, 0, 0);
    }

    setMatrixUniforms();
    gl.drawArrays(TRIANGLES, 0, numOfVerticies);

    mvPopMatrix();
  }
}

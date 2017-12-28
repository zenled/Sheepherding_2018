part of Sheep;

class SheepBody extends GameObject {
  SheepBody(GameObject parent) {
    this.parent = parent;

    List<double> vertices = <double>[
      // Front face
      0.0, 1.0, 0.0,
      -1.0, -1.0, 1.0,
      1.0, -1.0, 1.0,

      // Right face
      0.0, 1.0, 0.0,
      1.0, -1.0, 1.0,
      1.0, -1.0, -1.0,

      // Back face
      0.0, 1.0, 0.0,
      1.0, -1.0, -1.0,
      -1.0, -1.0, -1.0,

      // Left face
      0.0, 1.0, 0.0,
      -1.0, -1.0, -1.0,
      -1.0, -1.0, 1.0,

      //  NOTE: Missing the bottom triangles :)
      -1.0, -1.0, -1.0,
      1.0, -1.0, -1.0,
      1.0, -1.0, 1.0,
      -1.0, -1.0, -1.0,
      1.0, -1.0, 1.0,
      -1.0, -1.0, 1.0,
    ];
    super.setVertexBuffer(vertices);

    var colors = [
      // Front face
      1.0, 0.0, 0.0, 1.0,
      1.0, 0.0, 0.0, 1.0,
      1.0, 0.0, 0.0, 1.0,

      // Right face
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,

      // Back face
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,

      // Left face
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,

      // Bottom face
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 0.0, 1.0, 1.0
    ];
    super.setColorBuffer(colors);
  }
}

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
    //super.setColorBuffer(colors);

    List<double> textureCoord = <double>[
      // Front
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // Back
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // Top
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // Bottom
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // Right
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // Left
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0
    ];
    setTexture("crate.gif", textureCoord);
  }
}

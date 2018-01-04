part of Sheep;

class SheepBody extends GameObject {
  SheepBody(GameObject parent) {
    this.parent = parent;

    List<double> vertices = <double>[
      // Front face
      0.0, 0.5, 0.0,
      -0.5, -0.5, 0.5,
      0.5, -0.5, 0.5,

      // Right face
      0.0, 0.5, 0.0,
      0.5, -0.5, 0.5,
      0.5, -0.5, -0.5,

      // Back face
      0.0, 0.5, 0.0,
      0.5, -0.5, -0.5,
      -0.5, -0.5, -0.5,

      // Left face
      0.0, 0.5, 0.0,
      -0.5, -0.5, -0.5,
      -0.5, -0.5, 0.5,

      //  NOTE: Missing the bottom triangles :)
      -0.5, -0.5, -0.5,
      0.5, -0.5, -0.5,
      0.5, -0.5, 0.5,
      -0.5, -0.5, -0.5,
      0.5, -0.5, 0.5,
      -0.5, -0.5, 0.5,
    ];
    super.setVertexBuffer(vertices);

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
    setTexture("sheep_wool.gif", textureCoord);
  }
}

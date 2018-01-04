import '../game_object.dart';

class SheepHead extends GameObject {
  SheepHead() {
    List<double> vertices = <double>[
      // Front face
      0.0, 0.2, 0.0,
      -0.2, -0.2, 0.2,
      0.2, -0.2, 0.2,

      // Right face
      0.0, 0.2, 0.0,
      0.2, -0.2, 0.2,
      0.2, -0.2, -0.2,

      // Back face
      0.0, 0.2, 0.0,
      0.2, -0.2, -0.2,
      -0.2, -0.2, -0.2,

      // Left face
      0.0, 0.2, 0.0,
      -0.2, -0.2, -0.2,
      -0.2, -0.2, 0.2,

      //  NOTE: Missing the bottom triangles :)
      -0.2, -0.2, -0.2,
      0.2, -0.2, -0.2,
      0.2, -0.2, 0.2,
      -0.2, -0.2, -0.2,
      0.2, -0.2, 0.2,
      -0.2, -0.2, 0.2,
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
    setTexture("sheep_head.gif", textureCoord);
  }
}

library world;

import '../game_object.dart';

class World extends GameObject {
  static const size = 100.0;

  World() {
    List<double> vertices = <double>[
      // t0
      size, 0.0, -size,
      size, 0.0, size,
      -size, 0.0, size,
      // t1
      -size, 0.0, -size,
      size, 0.0, -size,
      -size, 0.0, size,
    ];
    setVertexBuffer(vertices);

    List<double> textureCoord = <double>[
      // t0
      1.0, 1.0,
      1.0, 0.0,
      0.0, 0.0,
      // t1
      0.0, 1.0,
      1.0, 1.0,
      0.0, 0.0,
    ];
    setTexture("water_texture.jpg", textureCoord);
  }
}

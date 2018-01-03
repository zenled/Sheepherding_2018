library world;

import '../game_object.dart';

class World extends GameObject {
  static const size = 50.0;

  int colorR = 100;
  int colorG = 196;
  int colorB = 78;

  double color_normalR;
  double color_normalG;
  double color_normalB;

  World() {
    // calculates color normals
    color_normalR = colorR / 255;
    color_normalG = colorG / 255;
    color_normalB = colorB / 255;

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

    // List<double> colors = <double>[
    //   // t0
    //   color_normalR, color_normalG, color_normalB, 1.0,
    //   color_normalR, color_normalG, color_normalB, 1.0,
    //   color_normalR, color_normalG, color_normalB, 1.0,
    //   // t1
    //   color_normalR, color_normalG, color_normalB, 1.0,
    //   color_normalR, color_normalG, color_normalB, 1.0,
    //   color_normalR, color_normalG, color_normalB, 1.0,
    // ];
    // setColorBuffer(colors);

    List<double> textureCoord = <double>[
    0.0,  0.0,
    1.0,  0.0,
    1.0,  1.0,
    0.0,  1.0,
        0.0,  0.0,
    1.0,  0.0,
    1.0,  1.0,
    0.0,  1.0,
    ];
    setTexture("grass.jpg", textureCoord);
  }
}

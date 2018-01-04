import '../game_object.dart';

class SheepLeg extends GameObject {
  static const double height = -0.5;

  SheepLeg() {
    List<num> verteces = <num>[
      // t0
      -0.05, 0, 0.05,
      0.05, 0, 0.05,
      -0.05, height, 0.05,
      // t1
      0.05, 0, 0.05,
      0.05, height, 0.05,
      -0.05, height, 0.05,
      // t2
      0.05, 0, -0.05,
      0.05, 0, 0.05,
      0.05, height, 0.05,
      // t3
      0.05, 0, -0.05,
      0.05, height, -0.05,
      0.05, height, 0.05,
      // t4
      0.05, 0, -0.05,
      -0.05, 0, -0.05,
      -0.05, height, -0.05,
      // t5
      0.05, 0, -0.05,
      -0.05, height, -0.05,
      0.05, height, -0.05,
      // t6
      -0.05, 0, -0.05,
      -0.05, 0, 0.05,
      -0.05, height, -0.05,
      // t7
      -0.05, 0, 0.05,
      -0.05, height, 0.05,
      -0.05, height, -0.05,
    ];
    List<double> vertecesDouble = verteces.map((num n) {
      return n as double;
    }).toList();

    setVertexBuffer(vertecesDouble);

    List<num> texture = <num>[
      // t0
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t1
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t2
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t3
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t4
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t5
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t6
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      // t7
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
    ];
    List<double> textureDouble = texture.map((num n) {
      return n as double;
    }).toList();

    setTexture("red.jpg", textureDouble);
  }
}

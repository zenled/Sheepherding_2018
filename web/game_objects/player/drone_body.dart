import '../game_object.dart';

class DroneBody extends GameObject {
  static const double thickness = -0.2;

  DroneBody() {
    List<num> verteces = <num>[
      // t0
      0.05, 0, -0.4,
      0.05, 0, 0.35,
      -0.05, 0, 0.35,
      // t1
      -0.05, 0, -0.4,
      0.05, 0, -0.4,
      -0.05, 0, 0.35,
      // t2
      -0.05, 0, 0.35,
      0.05, 0, 0.35,
      -0.05, thickness, 0.35,
      // t3
      0.05, 0, 0.35,
      0.05, thickness, 0.35,
      -0.05, thickness, 0.35,
      // t4 (t0 bottom)
      0.05, thickness, -0.4,
      0.05, thickness, 0.35,
      -0.05, thickness, 0.35,
      // t5 (t1 bottom)
      -0.05, thickness, -0.4,
      0.05, thickness, -0.4,
      -0.05, thickness, 0.35,
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
    ];
    List<double> textureDouble = texture.map((num n) {
      return n as double;
    }).toList();

    setTexture("galvanizedTexture.jpg", textureDouble);
  }
}

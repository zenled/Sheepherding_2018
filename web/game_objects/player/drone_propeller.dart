import '../game_object.dart';

class DronePropeller extends GameObject {
  static const roatationSpeed = -10.0;

  DronePropeller() {
    List<num> verteces = <num>[
      // t0
      0.025, 0, -0.075,
      0.025, 0, 0.075,
      -0.025, 0, 0.075,
      // t1
      -0.025, 0, -0.075,
      0.025, 0, -0.075,
      -0.025, 0, 0.075,
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
    ];
    List<double> textureDouble = texture.map((num n) {
      return n as double;
    }).toList();

    setTexture("galvanizedTexture.jpg", textureDouble);
  }

  @override
  void draw(){
    rotateY(roatationSpeed);

    super.draw();
  }
}

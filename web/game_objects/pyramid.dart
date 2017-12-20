part of game;

class Pyramid extends GameObject {
  Pyramid() {
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
      0.0, 0.0, 1.0, 1.0,

      // Right face
      1.0, 0.0, 0.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 1.0, 0.0, 1.0,

      // Back face
      1.0, 0.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0,
      0.0, 0.0, 1.0, 1.0,

      // Left face
      1.0, 0.0, 0.0, 1.0,
      0.0, 0.0, 1.0, 1.0,
      0.0, 1.0, 0.0, 1.0,

      // Bottom face
      0.0, 1.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0,
      0.0, 1.0, 0.0, 1.0
    ];
    super.setColorBuffer(colors);
  }

  // @override
  // void handleUserInput() {
  //   double speed = 0.04;
  //   double rotationSpeed = 2.0;

  //   if (keyboardHandler.isPressingFORWARD) {
  //     super.translateZ(-speed);
  //   }
  //   if (keyboardHandler.isPressingBACKWARD) {
  //     super.translateZ(speed);
  //   }
  //   if (keyboardHandler.isPressingRIGHT) {
  //     super.translateX(speed);
  //   }
  //   if (keyboardHandler.isPressingLEFT) {
  //     super.translateX(-speed);
  //   }
  //   if (keyboardHandler.isPressingROTATE_RIGHT) {
  //     super.rotateY(rotationSpeed);
  //   }
  //   if (keyboardHandler.isPressingROTATE_LEFT) {
  //     super.rotateY(-rotationSpeed);
  //   }
  // }
}

part of game;

class Player extends GameObject {
  GameObject mainChild;

  Player() {
    mainChild = new Pyramid();
    super.children.add(mainChild);
  }

  @override
  void translateX(double value) {
    x += cos(radians(180.0 - rotationY)) * -value;
    z += sin(radians(180.0 - rotationY)) * -value;
  }

  @override
  void translateZ(double value) {
    x += cos(radians(90.0 - rotationY)) * value;
    z += sin(radians(90.0 - rotationY)) * value;
  }

  @override
  void handleUserInput() {
    double speed = 0.04;
    double rotationSpeed = 2.0;
    double visualAngle = 10.0;

    if (keyboardHandler.isPressingFORWARD) {
      translateZ(-speed);
    }
    if (keyboardHandler.isPressingBACKWARD) {
      translateZ(speed);
    }
    if (keyboardHandler.isPressingRIGHT) {
      translateX(speed);
      rotationZ = -visualAngle;
    }
    else{
      rotationZ = 0.0;
    }
    if (keyboardHandler.isPressingLEFT) {
      translateX(-speed);
    }
    if (keyboardHandler.isPressingUP) {
      translateY(speed);
    }
    if (keyboardHandler.isPressingDOWN) {
      translateY(-speed);
    }
    if (keyboardHandler.isPressingROTATE_RIGHT) {
      rotateY(-rotationSpeed);
    }
    if (keyboardHandler.isPressingROTATE_LEFT) {
      rotateY(rotationSpeed);
    }
  }
}

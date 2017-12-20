part of game;

class Player extends GameObject {

  GameObject mainChild;

  Player(){
    mainChild = new Pyramid();
    super.children.add(mainChild);
  }

  @override
  void handleUserInput() {
    double speed = 0.04;
    double rotationSpeed = 2.0;

    if (keyboardHandler.isPressingFORWARD) {
      super.translateZ(-speed);
    }
    if (keyboardHandler.isPressingBACKWARD) {
      super.translateZ(speed);
    }
    if (keyboardHandler.isPressingRIGHT) {
      super.translateX(speed);
    }
    if (keyboardHandler.isPressingLEFT) {
      super.translateX(-speed);
    }
    if (keyboardHandler.isPressingROTATE_RIGHT) {
      super.rotateY(rotationSpeed);
      //mainChild.rotateY(rotationSpeed);
    }
    if (keyboardHandler.isPressingROTATE_LEFT) {
      super.rotateY(-rotationSpeed);
      //mainChild.rotateY(-rotationSpeed);
    }
  }
}

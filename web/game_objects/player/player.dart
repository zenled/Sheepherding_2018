part of game;

class Player extends GameObject {
  static const xSpeed = 0.04;
  static const ySpeed = 0.04;
  static const zSpeed = 0.04;
  
  static const yRotationSpeed = 2.0;

  // how many degrees shotld the drone tilt (this does not affect position)
  static const movingTilt_notMoving = 0.0;
  static const movingTilt_moving = 10.0;

  GameObject droneBody;

  Player() {
    droneBody = new Pyramid();
    addChild(droneBody);
  }

  @override
  void handleUserInput() {
    // Forward Backward
    bool preserveTiltFB = false;
    if (keyboardHandler.isPressingFORWARD) {
      translateZ(-zSpeed);
      droneBody.rotationX = -movingTilt_moving;
      preserveTiltFB = true;
    }
    if (keyboardHandler.isPressingBACKWARD) {
      translateZ(zSpeed);
      droneBody.rotationX = movingTilt_moving;
      preserveTiltFB = true;
    } 
    if (!preserveTiltFB) {
      droneBody.rotationX = movingTilt_notMoving;
    }

    // Left Right
    bool preserveTiltLR = false;
    if (keyboardHandler.isPressingRIGHT) {
      translateX(xSpeed);
      droneBody.rotationZ = -movingTilt_moving;
      preserveTiltLR = true;
    }
    if (keyboardHandler.isPressingLEFT) {
      translateX(-xSpeed);
      droneBody.rotationZ = movingTilt_moving;
      preserveTiltLR = true;
    } 
    if (!preserveTiltLR) {
      droneBody.rotationZ = movingTilt_notMoving;
    }

    // Up Down
    if (keyboardHandler.isPressingUP) {
      translateY(ySpeed);
    }
    if (keyboardHandler.isPressingDOWN) {
      translateY(-ySpeed);
    }

    // Rotation
    if (keyboardHandler.isPressingROTATE_RIGHT) {
      rotateY(-yRotationSpeed);
    }
    if (keyboardHandler.isPressingROTATE_LEFT) {
      rotateY(yRotationSpeed);
    }
  }
}

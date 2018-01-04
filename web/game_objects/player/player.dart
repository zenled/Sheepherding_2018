library Player;

import '../game_object.dart';
import '../pyramid.dart';

import '../sheep/i_sheep_herder.dart';

import 'drone_body.dart';
import 'drone_wing.dart';

class Player extends GameObject implements ISheepHerder {
  static const xSpeed = 0.04;
  static const ySpeed = 0.04;
  static const zSpeed = 0.04;

  static const initialPositionX = 0.0;
  static const initialPositionY = 10.0;
  static const initialPositionZ = 15.0;

  static const yRotationSpeed = 2.0;

  // how many degrees shotld the drone tilt (this does not affect position)
  static const movingTilt_notMoving = 0.0;
  static const movingTilt_moving = 10.0;

  GameObject droneBody;

  Player() {
    // sets inital position
    translateX(initialPositionX);
    translateY(initialPositionY);
    translateZ(initialPositionZ);

    //droneBody = new Pyramid();
    droneBody = new DroneBody();
    addChild(droneBody);

    // wings
    GameObject wingTL = new DroneWing();
    wingTL.x = -0.2;
    wingTL.z = -0.2;
    droneBody.addChild(wingTL);

    GameObject wingTR = new DroneWing();
    wingTR.x = 0.2;
    wingTR.z = -0.2;
    droneBody.addChild(wingTR);

    GameObject wingBL = new DroneWing();
    wingBL.x = -0.2;
    wingBL.z = 0.2;
    droneBody.addChild(wingBL);

    GameObject wingBR = new DroneWing();
    wingBR.x = 0.2;
    wingBR.z = 0.2;
    droneBody.addChild(wingBR);
  }

  @override
  void handleUserInput() {
    // Forward Backward
    bool preserveTiltFB = false;
    if (inputHandler.isPressingFORWARD) {
      translateZ(-zSpeed);
      droneBody.rotationX = -movingTilt_moving;
      preserveTiltFB = true;
    }
    if (inputHandler.isPressingBACKWARD) {
      translateZ(zSpeed);
      droneBody.rotationX = movingTilt_moving;
      preserveTiltFB = true;
    }
    if (!preserveTiltFB) {
      droneBody.rotationX = movingTilt_notMoving;
    }

    // Left Right
    bool preserveTiltLR = false;
    if (inputHandler.isPressingRIGHT) {
      translateX(xSpeed);
      droneBody.rotationZ = -movingTilt_moving;
      preserveTiltLR = true;
    }
    if (inputHandler.isPressingLEFT) {
      translateX(-xSpeed);
      droneBody.rotationZ = movingTilt_moving;
      preserveTiltLR = true;
    }
    if (!preserveTiltLR) {
      droneBody.rotationZ = movingTilt_notMoving;
    }

    // Up Down
    if (inputHandler.isPressingUP) {
      translateY(ySpeed);
    }
    if (inputHandler.isPressingDOWN) {
      translateY(-ySpeed);
    }

    // Rotation (roatating the camera left-right also moves the player)
    if (inputHandler.isPressingROTATE_RIGHT ||
        inputHandler.isPressingCAMERA_RIGHT) {
      rotateY(-yRotationSpeed);
    }
    if (inputHandler.isPressingROTATE_LEFT ||
        inputHandler.isPressingCAMERA_LEFT) {
      rotateY(yRotationSpeed);
    }
  }

  // ISheepHerder --------------------------------------------------------------------

  @override
  double get rotation => rotationY;
}

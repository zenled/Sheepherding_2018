library Sheep;

import 'dart:math';
import 'dart:html';

import '../game_object.dart';
import '../../math_util.dart' as math_util;
import '../../global.dart' as global;
import '../world/i_surface.dart';

import 'i_sheep_herder.dart';
part 'sheep_body.dart';

enum SheepState {
  eating,
  moving,
  drowned,
  dead,
}

class Sheep extends GameObject {
  // [herder] must be less than [attention_distance] away from Sheep in order for sheep to respond to it
  static const attention_distance = 30.0;

  // MoveAway (from [herder]) consts
  static const moveAway_maxRotation = 5.0;
  static const moveAway_movementSpeed = 0.02;

  // MoveFreely consts
  static const moveFreely_chanceOfStayingInPlace = 0.8;
  static const moveFreely_maxRotation = 10.0;
  static const moveFreely_maxMovementSpeed = 0.04;

  static const hungerLevelChange = 1.0;

  // Shomehing that herds sheep (sheep run away from this object)
  ISheepHerder herder;

  // sheep
  double hungerLevel = 100.0;
  SheepState state = SheepState.moving;

  // graphical
  SheepBody body;

  // indicators
  TableCellElement hungerIndicator;
  TableCellElement stateIndicator;

  Sheep(
    this.herder,
    this.hungerIndicator,
    this.stateIndicator,
  ) {
    body = new SheepBody(this);
    addChild(body);
  }

  void move() {
    if (state == SheepState.drowned || state == SheepState.dead) {
      return;
    }

    if (math_util.distance3D(herder.point3D, point3D) > attention_distance) {
      _moveFreely();
    } else {
      _moveAwayFromHerder();
    }
  }

  void updateState() {
    _updateState();
    _updateHungerLevel();

    _updateHungerIndicator();
    _updateStateIndicator();
  }

  // if [herder] is in sight move away from him
  void _moveAwayFromHerder() {
    // Rotates away from player
    Random rnd = new Random();
    double actualRotation = rotationY;

    double desiredRotation =
        math_util.angle2D(herder.point2D_birdView, this.point2D_birdView);
    desiredRotation += 90.0;

    if (actualRotation >= desiredRotation) {
      actualRotation -= rnd.nextDouble() * moveAway_maxRotation;
    } else {
      actualRotation += rnd.nextDouble() * moveAway_maxRotation;
    }
    rotationY = actualRotation;

    translateZ(moveAway_movementSpeed);
  }

  // if [herder] is not in sight the sheep moves freely
  void _moveFreely() {
    Random rnd = new Random();

    // might not move
    if (rnd.nextDouble() < moveFreely_chanceOfStayingInPlace) {
      return;
    }

    // rotates randomly
    double rotation = rnd.nextDouble() * moveFreely_maxRotation;
    if (rnd.nextBool()) {
      rotation = -rotation;
    }
    rotateY(rotation);

    // translates randomly
    double translation = rnd.nextDouble() * moveFreely_maxMovementSpeed;
    translateZ(translation);
  }

  void _updateState() {
    // once a sheep is drowned it is drowned forever
    if (state == SheepState.drowned) {
      return;
    }

    if (hungerLevel <= 0) {
      state = SheepState.dead;
      return;
    }

    math_util.Point2D collisionDetectionPoint = point2D_birdView;
    collisionDetectionPoint.y = -collisionDetectionPoint.y;

    // checks if it is on a grass patch
    for (ISurface grassPatch in global.grassController.grassPaches) {
      for (math_util.Triangle triangle
          in grassPatch.getCollisionDetectionTriangles()) {
        if (math_util.isPointInTriangle(collisionDetectionPoint, triangle)) {
          state = SheepState.eating;
          return;
        }
      }
    }

    // checks if on a dirt patch
    for (ISurface dirtPatch in global.dirtController.dirtPaches) {
      for (math_util.Triangle triangle
          in dirtPatch.getCollisionDetectionTriangles()) {
        if (math_util.isPointInTriangle(collisionDetectionPoint, triangle)) {
          state = SheepState.moving;
          return;
        }
      }
    }

    state = SheepState.drowned;
  }

  void _updateHungerLevel() {
    switch (state) {
      case SheepState.drowned:
        break;
      case SheepState.dead:
        break;
      case SheepState.eating:
        hungerLevel += hungerLevelChange;
        break;
      case SheepState.moving:
        hungerLevel -= hungerLevelChange;
        break;
    }

    if (hungerLevel > 100.0){
      hungerLevel = 100.0;
    }
  }

  void _updateHungerIndicator() {
    if (state == SheepState.dead || state == SheepState.drowned) {
      hungerIndicator.innerHtml = "____";
    } else {
      hungerIndicator.innerHtml = "$hungerLevel%";
    }
  }

  void _updateStateIndicator() {
    String stateString;
    switch (state) {
      case SheepState.moving:
        stateString = "Moving";
        break;
      case SheepState.eating:
        stateString = "Eating";
        break;
      case SheepState.drowned:
        stateString = "Drowned";
        break;
      case SheepState.dead:
        stateString = "Dead";
        break;
    }

    stateIndicator.innerHtml = "$stateString";
  }
}

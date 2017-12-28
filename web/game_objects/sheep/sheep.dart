library Sheep;

import 'dart:math';

import '../game_object.dart';
import '../../math_util.dart' as math_util;

import 'i_sheep_herder.dart';
part 'sheep_body.dart';

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

  // Shomehing that herds sheep (sheep run away from this object)
  ISheepHerder herder;

  SheepBody body;

  Sheep(this.herder) {
    body = new SheepBody(this);
    addChild(body);
  }

  void move() {
    // if herder away enough it doesn't move
    if (math_util.distance3D(herder.point3D, point3D) > attention_distance) {
      _moveFreely();
    } else {
      _moveAwayFromHerder();
    }
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
}

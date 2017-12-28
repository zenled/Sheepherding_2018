library Sheep;

import '../game_object.dart';
import '../../math_util.dart' as math_util;

import 'i_sheep_herder.dart';
part 'sheep_body.dart';

class Sheep extends GameObject {
  // [herder] must be less than [attention_distance] away from Sheep in order for sheep to respond to it
  static const attention_distance = 20.0;

  static const movement_speed = 0.02;

  // Shomehing that herds sheep (sheep run away from this object)
  ISheepHerder herder;

  SheepBody body;

  Sheep(this.herder) {
    body = new SheepBody(this);
    addChild(body);
  }

  void move() {
    // rotates away from player
    rotationY =
        math_util.angle2D(herder.point2D_birdView, this.point2D_birdView);
    rotateY(90.0);

    // if herder away enough it doesn't move
    if (math_util.distance3D(herder.point3D, point3D) > attention_distance) {
      return;
    }

    translateZ(movement_speed);
  }
}

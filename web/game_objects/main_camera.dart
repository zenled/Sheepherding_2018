import 'dart:web_gl' as web_gl;

import '../matrix4.dart';
import 'game_object.dart';

class Camera {
  final double aspectRatio;

  final GameObject followingObject;

  double x;
  double y;
  double z;

  double rotationX;
  double rotationY;

  Camera(this.aspectRatio, this.followingObject) {
    x = 0.0;
    y = 0.0;
    z = 0.0;

    rotationX = 0.0;
    rotationY = 0.0;
  }

  /// Changes x by [moveBy]
  void moveX(double moveBy) => x -= moveBy;

  /// Changes y by [moveBy]
  void moveY(double moveBy) => y -= moveBy;

  /// Changes z by [moveBy]
  void moveZ(double moveBy) => z -= moveBy;

  /// Rotates Camera on Y-axis by [rotateBy]
  void rotateY(double rotateBy) => rotationY -= rotateBy;

  Matrix4 getPMatrix() {
    Matrix4 r = Matrix4.perspective(45.0, aspectRatio, 0.1, 100.0);

    

    //r.rotateX(0.9);
    //r.translate([-followingObject.x, -followingObject.y, -followingObject.z]);
    //r.translate([0.0, -5.0, -5.0]);
    r.translate([0.0,-2.0,-10.0]);

    //r.rotateY(-followingObject.rotationY);


    // //r.rotateX(1.5);
    // r.rotateX(0.9);
    // r.rotateY(rotationY);
    // r.translate([-followingObject.x, -followingObject.y, -followingObject.z]);
    // r.translate([0.0, -5.0, -5.0]);
    
    return r;
  }
}

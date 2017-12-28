import 'game_object.dart';
import '../global.dart';

class MainCamera {
  static const fovy_degrees = 45.0;
  static const near_plane = 0.1;
  static const far_plane = 100.0;

  // at what position relative to [following] will the camera be
  static const offsetX = 0.0;
  static const offsetY = -2.0;
  static const offsetZ = -10.0;

  static const _initial_rotationX = 20.0;
  static const _rotation_speed = 1.0;
  static const _minRotationX = -40.0;
  static const _maxRotationX = 80.0;

  double rotationX;

  final GameObject following;

  /// GameObject that the camera will follow

  MainCamera(this.following) {
    rotationX = _initial_rotationX;
  }

  void updatePMatrix() {
    pMatrix = Matrix4.perspective(
      fovy_degrees,
      canvas.width / canvas.height,
      near_plane,
      far_plane,
    );

    Matrix4 m4 = new Matrix4()..identity();
    m4.rotateX(radians(rotationX));
    m4.rotateY(radians(-following.rotationY));
    pMatrix.translate([offsetX, offsetY, offsetZ]);
    m4.translate([-following.x, -following.y, -following.z]);

    pMatrix *= m4;
  }

  void handleUserInput() {
    if (inputHandler.isPressingCAMERA_UP ||
        inputHandler.isPressingCAMERA_DOWN) {
      if (inputHandler.isPressingCAMERA_UP) {
        rotationX += _rotation_speed;
      }
      if (inputHandler.isPressingCAMERA_DOWN) {
        rotationX -= _rotation_speed;
      }
      if (rotationX < _minRotationX){
        rotationX = _minRotationX;
      }
      if (rotationX > _maxRotationX){
        rotationX = _maxRotationX;
      }
    }
  }
}

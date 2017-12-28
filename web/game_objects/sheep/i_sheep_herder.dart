import '../../math_util.dart' as math_util;

abstract class ISheepHerder {
  double get x;
  double get y;
  double get z;

  double get rotation;

  math_util.Point3D get point3D;

  math_util.Point2D get point2D_birdView;
}
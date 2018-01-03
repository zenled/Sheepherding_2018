import '../../math_util.dart';

abstract class ISurface {
  List<Triangle> getCollisionDetectionTriangles();
}
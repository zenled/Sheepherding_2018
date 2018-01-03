import '../../math_util.dart';
import '../game_object.dart';
import 'i_surface.dart';

class Grass extends GameObject implements ISurface {
  List<Triangle> collisionDetectionTriangles = <Triangle>[];

  Grass(List<double> verteces, List<double> textureCoords) {
    setVertexBuffer(verteces);
    setTexture("grass.jpg", textureCoords);

    for (int i = 0; i < verteces.length; i++) {
      Point2D p1 = new Point2D(verteces[i], verteces[i + 2]);
      i += 3;
      Point2D p2 = new Point2D(verteces[i], verteces[i + 2]);
      i += 3;
      Point2D p3 = new Point2D(verteces[i], verteces[i + 2]);
      i += 2;

      Triangle triangle = new Triangle(p1, p2, p3);
      collisionDetectionTriangles.add(triangle);
    }
  }

  @override
  List<Triangle> getCollisionDetectionTriangles() {
    return collisionDetectionTriangles;
  }
}

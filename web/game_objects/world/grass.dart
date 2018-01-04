import 'dart:html';

import '../../math_util.dart';
import '../game_object.dart';
import 'i_surface.dart';

class Grass extends GameObject implements ISurface {
  static const regeneration_speed = 0.25;
  static const sheepEatsPerTick = 1.0;

  double ammountOfGarass = 100.0;
  int numOfSheepOnGrass = 0;

  TableCellElement grassStateIndicator;

  List<Triangle> collisionDetectionTriangles = <Triangle>[];

  Grass(List<double> verteces, List<double> textureCoords,
      this.grassStateIndicator) {
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

  void updateState() {
    ammountOfGarass += regeneration_speed;
    if (ammountOfGarass > 100.0) {
      ammountOfGarass = 100.0;
    }

    ammountOfGarass -= numOfSheepOnGrass * sheepEatsPerTick;
    if (ammountOfGarass < 0.0) {
      ammountOfGarass = 0.0;
    }

    numOfSheepOnGrass = 0;

    _updateStateIndicator();
  }

  void _updateStateIndicator() {
    grassStateIndicator.innerHtml = "$ammountOfGarass%";
  }
}

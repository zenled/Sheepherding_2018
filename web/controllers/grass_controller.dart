import '../game_objects/game_object.dart';
import '../game_objects/world/grass.dart';

import 'grasses.dart';


class GrassController {
  static const grassY = 0.03;

  List<Grass> grassPaches = <Grass>[];

  GameObject rootObject;

  GrassController(this.rootObject) {
    _createLakes();
  }

  void _createLakes() {
    for (int i = 0; i < grass_verteces.length; i++) {
      // transforms all verteces to double
      List<double> verteces = grass_verteces[i].map((num n) {
        return n as double;
      }).toList();
      // transforms all texture coords to double
      List<double> textureCoords = grass_verteces[i].map((num n) {
        return n as double;
      }).toList();

      // creates a new lake
      Grass grass = new Grass(verteces, textureCoords);
      grass.y = grassY;
      grassPaches.add(grass);

      grass.parent = rootObject;
      rootObject.addChild(grass);
    }
  }
}

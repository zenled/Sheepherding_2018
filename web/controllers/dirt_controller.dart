import '../game_objects/game_object.dart';
import '../game_objects/world/dirt.dart';

import 'dirts.dart';


class DirtController {
  static const dirtY = 0.02;

  List<Dirt> dirtPaches = <Dirt>[];

  GameObject rootObject;

  DirtController(this.rootObject) {
    _createDirts();
  }

  void _createDirts() {
    for (int i = 0; i < dirt_verteces.length; i++) {
      // transforms all verteces to double
      List<double> verteces = dirt_verteces[i].map((num n) {
        return n as double;
      }).toList();
      // transforms all texture coords to double
      List<double> textureCoords = dirt_textureCoords[i].map((num n) {
        return n as double;
      }).toList();

      // creates a new lake
      Dirt dirt = new Dirt(verteces, textureCoords);
      dirt.y = dirtY;
      dirtPaches.add(dirt);

      dirt.parent = rootObject;
      rootObject.addChild(dirt);
    }
  }
}

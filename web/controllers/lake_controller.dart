import '../game_objects/game_object.dart';
import '../game_objects/world/lake.dart';

import 'lakes.dart';

class LakeController {
  static const lakeY = 0.02;

  List<Lake> lakes = <Lake>[];

  GameObject rootObject;

  LakeController(this.rootObject) {
    _createLakes();
  }

  void _createLakes() {
    for (int i = 0; i < lakes_verteces.length; i++) {
      // transforms all verteces to double
      List<double> verteces = lakes_verteces[i].map((num n) {
        return n as double;
      }).toList();
      // transforms all texture coords to double
      List<double> textureCoords = lakes_textureCoords[i].map((num n) {
        return n as double;
      }).toList();

      // creates a new lake
      Lake lake = new Lake(verteces, textureCoords);
      lake.y = lakeY;
      lakes.add(lake);

      lake.parent = rootObject;
      rootObject.addChild(lake);
    }
  }
}

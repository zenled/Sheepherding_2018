import 'dart:html';

import '../game_objects/game_object.dart';
import '../game_objects/sheep/sheep.dart';
import '../game_objects/sheep/i_sheep_herder.dart';

const _creator_num_of_sheep = 9;
const _creator_sheep_in_row = 3;
const _creator_sheep0_x = -2.0;
const _creator_sheep0_z = -5.0;
const _creator_distance = 2.0;

const walking_plane_y = 1.1;

class HerdController {
  final GameObject rootObject;
  final ISheepHerder sheepHerder;

  List<Sheep> _herdMembers = <Sheep>[];

  HerdController(this.rootObject, this.sheepHerder) {
    _createHerdMembers();
  }

  void moveHerdMembers() {
    for (Sheep sheep in _herdMembers) {
      sheep.move();
    }
  }

  void updateHerdMembersState(){
    for (Sheep sheep in _herdMembers){
      sheep.updateState();
    }
  }

  void _createHerdMembers() {
    int row = 0;
    int column = 0;
    for (int i = 0; i < _creator_num_of_sheep; i++) {
      Sheep sheep = new Sheep(
        sheepHerder,
        querySelector("#sheepHunger$i") as TableCellElement,
        querySelector("#sheepState$i") as TableCellElement,
      );

      // sets inital position
      sheep.y = 1.2;

      double z = _creator_sheep0_z;
      z += row * _creator_distance;
      sheep.z = z;

      double x = _creator_sheep0_x;
      x += column * _creator_distance;
      sheep.x = x;

      rootObject.addChild(sheep);
      _herdMembers.add(sheep);

      column++;
      if (column == _creator_sheep_in_row) {
        row++;
        column = 0;
      }
    }

    //   for (int i = 0; i < _initial_num_of_sheep; i++){
    //     Sheep sheep = new Sheep(sheepHerder);
    //     sheep.translateY(walking_plane_y);
    //     sheep.z = -10.0;

    //     if (i == 0){
    //       sheep.x = -5.0;
    //     }

    //     if (i == 2){
    //       sheep.x = 5.0;
    //     }

    //     rootObject.addChild(sheep);
    //     _herdMembers.add(sheep);
    //   }
  }
}

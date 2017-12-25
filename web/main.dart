import 'dart:html';

import 'global.dart' as global;
import 'game.dart';


void main() {
  global.canvas = querySelector("#canvas");
  global.gl = global.canvas.getContext3d();

  global.game = new Game();
  global.game.startGame();
}

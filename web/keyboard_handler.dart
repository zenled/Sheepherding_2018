import 'dart:html';

const _keyCode_A = 65;
const _keyCode_S = 83;
const _keyCode_D = 68;
const _keyCode_W = 87;

class KeyboardHandler {
  final Window window;

  bool _keyDown_UP = false;
  bool _keyDown_DOWN = false;
  bool _keyDown_LEFT = false;
  bool _keyDown_RIGHT = false;

  KeyboardHandler(this.window) {
    window.onKeyDown.listen(onKeyDown);
    window.onKeyUp.listen(onKeyUp);
  }

  void onKeyDown(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case _keyCode_A:
        _keyDown_LEFT = true;
        break;
      case _keyCode_S:
        _keyDown_DOWN = true;
        break;
      case _keyCode_D:
        _keyDown_RIGHT = true;
        break;
      case _keyCode_W:
        _keyDown_UP = true;
        break;
    }
  }

  void onKeyUp(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case _keyCode_A:
        _keyDown_LEFT = false;
        break;
      case _keyCode_S:
        _keyDown_DOWN = false;
        break;
      case _keyCode_D:
        _keyDown_RIGHT = false;
        break;
      case _keyCode_W:
        _keyDown_UP = false;
        break;
    }
  }

  bool get isPressingUP => _keyDown_UP;
  bool get isPressingDOWN => _keyDown_DOWN;
  bool get isPressingLEFT => _keyDown_LEFT;
  bool get isPressingRIGHT => _keyDown_RIGHT;
}

import 'dart:html';

const _keyCode_A = 65;
const _keyCode_S = 83;
const _keyCode_D = 68;
const _keyCode_W = 87;

const _keyCode_Q = 81;
const _keyCode_E = 69;

const _keyCode_SPACE = 32;

const _keyCode_UP = 38;
const _keyCode_DOWN = 40;
const _keyCode_LEFT = 37;
const _keyCode_RIGHT = 39;

const _keyCode_SHIFT = 16;
const _keyCode_CTRL = 17;

class InputHandler {
  final Window window;

  bool _keyDown_FORWARD = false;
  bool _keyDown_BACKWARD = false;
  bool _keyDown_LEFT = false;
  bool _keyDown_RIGHT = false;

  bool _keyDown_UP = false;
  bool _keyDown_DOWN = false;

  bool _keyDown_ROTATE_LEFT = false;
  bool _keyDown_ROTATE_RIGHT = false;

  bool _keyDown_CAMERA_UP = false;
  bool _keyDown_CAMERA_DOWN = false;
  bool _keyDown_CAMERA_LEFT = false;
  bool _keyDown_CAMERA_RIGHT = false;

  InputHandler(this.window) {
    window.onKeyDown.listen(onKeyDown);
    window.onKeyUp.listen(onKeyUp);
  }

  void onKeyDown(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case _keyCode_A:
        _keyDown_LEFT = true;
        break;
      case _keyCode_S:
        _keyDown_BACKWARD = true;
        break;
      case _keyCode_D:
        _keyDown_RIGHT = true;
        break;
      case _keyCode_W:
        _keyDown_FORWARD = true;
        break;
      case _keyCode_SHIFT:
        _keyDown_DOWN = true;
        break;
      // case _keyCode_CTRL:
      //   _keyDown_DOWN = true;
      //   break;
      case _keyCode_SPACE:
        _keyDown_UP = true;
        break;
      case _keyCode_Q:
        _keyDown_ROTATE_LEFT = true;
        break;
      case _keyCode_E:
        _keyDown_ROTATE_RIGHT = true;
        break;
      case _keyCode_UP:
        _keyDown_CAMERA_UP = true;
        break;
      case _keyCode_DOWN:
        _keyDown_CAMERA_DOWN = true;
        break;
      case _keyCode_LEFT:
        _keyDown_CAMERA_LEFT = true;
        break;
      case _keyCode_RIGHT:
        _keyDown_CAMERA_RIGHT = true;
        break;
    }

    if (keyboardEvent.keyCode != 116) {
      keyboardEvent.preventDefault();
    }
  }

  void onKeyUp(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case _keyCode_A:
        _keyDown_LEFT = false;
        break;
      case _keyCode_S:
        _keyDown_BACKWARD = false;
        break;
      case _keyCode_D:
        _keyDown_RIGHT = false;
        break;
      case _keyCode_W:
        _keyDown_FORWARD = false;
        break;
      case _keyCode_SHIFT:
        _keyDown_DOWN = false;
        break;
      // case _keyCode_CTRL:
      //   _keyDown_DOWN = false;
      //   break;
      case _keyCode_SPACE:
        _keyDown_UP = false;
        break;
      case _keyCode_Q:
        _keyDown_ROTATE_LEFT = false;
        break;
      case _keyCode_E:
        _keyDown_ROTATE_RIGHT = false;
        break;
      case _keyCode_UP:
        _keyDown_CAMERA_UP = false;
        break;
      case _keyCode_DOWN:
        _keyDown_CAMERA_DOWN = false;
        break;
      case _keyCode_LEFT:
        _keyDown_CAMERA_LEFT = false;
        break;
      case _keyCode_RIGHT:
        _keyDown_CAMERA_RIGHT = false;
        break;
    }
  }

  bool get isPressingFORWARD => _keyDown_FORWARD;
  bool get isPressingBACKWARD => _keyDown_BACKWARD;
  bool get isPressingLEFT => _keyDown_LEFT;
  bool get isPressingRIGHT => _keyDown_RIGHT;

  bool get isPressingUP => _keyDown_UP;
  bool get isPressingDOWN => _keyDown_DOWN;

  bool get isPressingROTATE_LEFT => _keyDown_ROTATE_LEFT;
  bool get isPressingROTATE_RIGHT => _keyDown_ROTATE_RIGHT;

  bool get isPressingCAMERA_UP => _keyDown_CAMERA_UP;
  bool get isPressingCAMERA_DOWN => _keyDown_CAMERA_DOWN;
  bool get isPressingCAMERA_LEFT => _keyDown_CAMERA_LEFT;
  bool get isPressingCAMERA_RIGHT => _keyDown_CAMERA_RIGHT;
}

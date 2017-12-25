import 'dart:html';

const _keyCode_A = 65;
const _keyCode_S = 83;
const _keyCode_D = 68;
const _keyCode_W = 87;

const _keyCode_SHIFT = 16;
const _keyCode_CTRL = 17;

const _keyCode_Q = 81;
const _keyCode_E = 69;

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

  double _lastMouse_x = 0.0;
  double _lastMouse_y = 0.0;
  double _mouseMove_x = 0.0;
  double _mouseMove_y = 0.0;

  InputHandler(this.window) {
    window.onKeyDown.listen(onKeyDown);
    window.onKeyUp.listen(onKeyUp);

    window.onMouseMove.listen(onMouseMove);
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
        _keyDown_UP = true;
        break;
      case _keyCode_CTRL:
        _keyDown_DOWN = true;
        break;
      case _keyCode_Q:
        _keyDown_ROTATE_LEFT = true;
        break;
      case _keyCode_E:
        _keyDown_ROTATE_RIGHT = true;
        break;
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
        _keyDown_UP = false;
        break;
      case _keyCode_CTRL:
        _keyDown_DOWN = false;
        break;
      case _keyCode_Q:
        _keyDown_ROTATE_LEFT = false;
        break;
      case _keyCode_E:
        _keyDown_ROTATE_RIGHT = false;
        break;
    }
  }

  void onMouseMove(MouseEvent mouseEvent) {
    double newMouse_x = mouseEvent.layer.x;
    double newMouse_y = mouseEvent.layer.y;

    _mouseMove_x = newMouse_x - _lastMouse_x;
    _mouseMove_y = newMouse_y - _lastMouse_y;

    _lastMouse_x = newMouse_x;
    _lastMouse_y = newMouse_y;
  }

  bool get isPressingFORWARD => _keyDown_FORWARD;
  bool get isPressingBACKWARD => _keyDown_BACKWARD;
  bool get isPressingLEFT => _keyDown_LEFT;
  bool get isPressingRIGHT => _keyDown_RIGHT;

  bool get isPressingUP => _keyDown_UP;
  bool get isPressingDOWN => _keyDown_DOWN;

  bool get isPressingROTATE_LEFT => _keyDown_ROTATE_LEFT;
  bool get isPressingROTATE_RIGHT => _keyDown_ROTATE_RIGHT;

  double getMouseMoveX({bool resetMove = true}) {
    double r = _mouseMove_x;
    if (resetMove) {
      _mouseMove_x = 0.0;
    }
    return r;
  }

  double getMouseMoveY({bool resetMove = true}) {
    double r = _mouseMove_y;
    if (resetMove) {
      _mouseMove_y = 0.0;
    }
    return r;
  }
}

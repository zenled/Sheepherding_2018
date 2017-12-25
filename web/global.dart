import 'dart:html';
import 'dart:web_gl';

import 'game.dart';
import 'matrix4.dart';
import 'input_handler.dart';

/// All global variables and methods should be in here

CanvasElement canvas;
RenderingContext gl;

Game game;

int get attributePointerVertex => game.attributePointerVertex;

int get attributePointerColor => game.attributePointerColor;

Matrix4 get pMatrix => game.pMatrix;

Matrix4 get mvMatrix => game.mvMatrix;

mvPushMatrix() => game.mvPushMatrix();

mvPopMatrix() => game.mvPopMatrix();

setMatrixUniforms() => game.setMatrixUniforms();

InputHandler get inputHandler => game.inputHandler;
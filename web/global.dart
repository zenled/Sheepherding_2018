import 'dart:async';
import 'dart:html';
import 'dart:web_gl';

import 'game.dart';
import 'matrix4.dart';
import 'input_handler.dart';
import 'controllers/dirt_controller.dart';
import 'controllers/grass_controller.dart';

/// All global variables and methods should be in here

CanvasElement canvas;
RenderingContext gl;

Game game;

DirtController get dirtController => game.dirtController;

GrassController get grassController => game.grassConroller;

int get attributePointerVertex => game.attributePointerVertex;

int get attributePointerColor => game.attributePointerColor;

int get attributePointerTextureCoord => game.attributePointerTextureCoord;

UniformLocation get uSampler => game.uniformLocationSampler;

Matrix4 get pMatrix => game.pMatrix;

void set pMatrix(Matrix4 value) => game.pMatrix = value;

Matrix4 get mvMatrix => game.mvMatrix;

mvPushMatrix() => game.mvPushMatrix();

mvPopMatrix() => game.mvPopMatrix();

setMatrixUniforms() => game.setMatrixUniforms();

InputHandler get inputHandler => game.inputHandler;

Future<Texture> loadTexture(String url, handle(Texture tex, ImageElement ele)) {
  var completer = new Completer<Texture>();
  var texture = gl.createTexture();
  var element = new ImageElement();
  element.onLoad.listen((e) {
    handle(texture, element);
    completer.complete(texture);
  });
  element.src = url;
  return completer.future;
}
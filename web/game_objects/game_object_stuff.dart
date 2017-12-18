import 'dart:web_gl' as web_gl;
import '../matrix4.dart';

web_gl.RenderingContext gl;
Function setUniforms;
int attributePointer_vertex;
int attributePointer_color;

Matrix4 mvMatrix;

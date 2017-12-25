const String source_code = '''
attribute vec3 aVertexPosition;
attribute vec4 aVertexColor;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;

varying vec4 vColor;

void main(void) {
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
    vColor = aVertexColor;
}
''';

const String attribute_neme_vertexPosition = "aVertexPosition";
const String attribute_name_vertexColor = "aVertexColor";

const String uniform_name_mvMatrix = "uMVMatrix";
const String uniform_name_pMatrix = "uPMatrix";

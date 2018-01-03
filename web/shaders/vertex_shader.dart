const String source_code = '''
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;

uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;

varying vec2 vTextureCoord;

void main(void) {
    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
    vTextureCoord = aTextureCoord;
}
''';

const String attribute_neme_vertexPosition = "aVertexPosition";
const String attribute_name_vertexColor = "aVertexColor";
const String attribute_name_textureCoord = "aTextureCoord";

const String uniform_name_mvMatrix = "uMVMatrix";
const String uniform_name_pMatrix = "uPMatrix";
const String uniform_name_sampler = "uSampler";

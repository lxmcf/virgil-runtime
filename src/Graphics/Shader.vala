namespace Virgil.Graphics {
    public class Shader {
        private Raylib.Shader _shader;

        public Shader (string vertex, string fragment) {
            _shader = Raylib.load_shader_from_memory (vertex, fragment);
        }

        //  Shader file extension: .vglsl (Virgil GLSL)
        public Shader.from_file (string filename) {

        }
    }
}

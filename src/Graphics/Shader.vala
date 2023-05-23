//  FIXME: No shader freeing

namespace Virgil.Graphics {
    [Version (experimental = true)]
    public class Shader {
        private const int SHADER_VERTEX = 1;
        private const int SHADER_FRAGMENT = 2;

        private Raylib.Shader _shader;

        public Shader (string vertex_file, string fragment_file) {
            _shader = Raylib.load_shader (vertex_file, fragment_file);
        }

        public Shader.from_strings (string vertex, string fragment) {
            _shader = Raylib.load_shader_from_memory (vertex, fragment);
        }

        public Shader.from_file (string filename) {
            string adjusted_filename = GLib.Environment.get_current_dir () + "/" + filename;
            FileStream? stream = FileStream.open (adjusted_filename, "r");

            if (stream == null) return;

            string vertex_string = "";
            string fragment_string = "";

            string? current_line = "";
            int mode = 0;

            while ((current_line = stream.read_line ()) != null) {
                if (current_line.contains ("#shader")) {
                    if (current_line.contains ("vertex")) mode = SHADER_VERTEX;
                    if (current_line.contains ("fragment")) mode = SHADER_FRAGMENT;

                    continue;
                }

                switch (mode) {
                    case SHADER_VERTEX:
                        vertex_string += current_line + "\n";
                    break;

                    case SHADER_FRAGMENT:
                        fragment_string += current_line + "\n";
                    break;
                }
            }

            _shader = Raylib.load_shader_from_memory (vertex_string, fragment_string);
        }

        ~Shader () {
            if (!Raylib.is_shader_ready (_shader)) return;

            Raylib.unload_shader (_shader);
        }

        public void set_target () {
            if (!Raylib.is_shader_ready (_shader)) return;

            Raylib.begin_shader_mode (_shader);
        }

        public void reset_target () {
            if (!Raylib.is_shader_ready (_shader)) return;

            Raylib.end_shader_mode ();
        }

        public int get_uniform_location (string uniform) {
            return Raylib.get_shader_location (_shader, uniform);
        }

        public int get_attribute_location (string attribute) {
            return Raylib.get_shader_location_attribute (_shader, attribute);
        }

        public void set_value (int location, void* value, ShaderDataType type) {
            Raylib.set_shader_value (_shader, location, value, (Raylib.ShaderUniformDataType)type);
        }

        public void set_value_array (int location, void* value, ShaderDataType type, int count) {
            Raylib.set_shader_value_vector (_shader, location, value, (Raylib.ShaderUniformDataType)type, count);
        }

        public void set_texture (int location, Texture2D texture) {
            Raylib.set_shader_value_texture (_shader, location, texture.get_raylib_target ());
        }
    }
}

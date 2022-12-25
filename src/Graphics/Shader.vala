namespace Virgil.Graphics {
    public class Shader {
        private const int SHADER_VERTEX = 1;
        private const int SHADER_FRAGMENT = 2;

        private Raylib.Shader? _shader;

        public Shader (string vertex_file, string fragment_file) {
            _shader = Raylib.load_shader (vertex_file, fragment_file);
        }

        public Shader.from_strings (string vertex, string fragment) {
            _shader = Raylib.load_shader_from_memory (vertex, fragment);
        }

        public Shader.from_file (string filename) {
            FileStream? stream = FileStream.open (GLib.Environment.get_current_dir () + "/" + filename, "r");

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
            if (_shader == null) return;

            Raylib.unload_shader (_shader);
        }

        public void begin () {
            if (_shader == null) return;

            Raylib.begin_shader_mode (_shader);
        }

        public void end () {
            if (_shader == null) return;

            Raylib.end_shader_mode ();
        }
    }
}

namespace Virgil.Graphics {
    public class Font {
        private Raylib.Font _font;

        public Font (string filename) {
            _font = Raylib.load_font (filename);
        }

        ~Font () {
            Raylib.unload_font (_font);
        }
    }
}

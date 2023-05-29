using Virgil.Runtime;

namespace Virgil.Graphics {
    public class Font {
        private Raylib.Font _font;
        private string _file;

        public float size { get; private set; }
        public float spacing { get; private set; }

        public Font (string filename) {
            _font = Raylib.load_font (filename);
            _file = filename;

            this.size = (float)_font.baseSize;
            spacing = 2.0f;

            Raylib.set_texture_filter (_font.texture, Raylib.TextureFilter.POINT);
        }

        public Font.from_ttf (string filename, int size) {
            int[] characters = { };

            _font = Raylib.load_font_ext (filename, size, characters);
            _file = filename;

            this.size = (float)size;
            spacing = 2.0f;

            Raylib.set_texture_filter (_font.texture, Raylib.TextureFilter.POINT);
        }

        ~Font () {
            Raylib.unload_font (_font);
        }

        public Vector2 get_text_size (string text) {
            if (!Raylib.is_font_ready (_font)) return Vector2.ZERO;

            return get_text_size_ext (text, (int)size);
        }

        public Vector2 get_text_size_ext (string text, int size) {
            if (!Raylib.is_font_ready (_font)) return Vector2.ZERO;

            Raylib.Vector2 text_size = Raylib.measure_text_ext (_font, text, (float)size, spacing);

            return { text_size.x, text_size.y };
        }

        public void draw_text (string text, Vector2 position, Colour colour = Colour.WHITE) {
            if (!Raylib.is_font_ready (_font)) return;

            Raylib.draw_text_ext (_font, text, { position.x, position.y }, size, spacing, { colour.r, colour.g, colour.b, colour.a });
        }
    }
}

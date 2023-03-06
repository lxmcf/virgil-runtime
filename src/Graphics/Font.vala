using Virgil.Runtime;

namespace Virgil.Graphics {
    public class Font {
        private unowned Raylib.Font _font;
        private string _file;

        public float size { get; private set; }
        public float spacing { get; private set; }

        public Font (string filename) {
            Raylib.Font font = Raylib.load_font (filename);
            _file = filename;

            this.size = (float)font.baseSize;
            spacing = 2.0f;

            Raylib.set_texture_filter (font.texture, Raylib.TextureFilter.POINT);

            _font = FontCache.register (font);
        }

        public Font.from_ttf (string filename, int size) {
            int[] characters = { };

            //  Load default character set
            Raylib.Font font = Raylib.load_font_ext (filename, size, characters);
            _file = filename;

            this.size = (float)size;
            spacing = 2.0f;

            Raylib.set_texture_filter (font.texture, Raylib.TextureFilter.POINT);

            _font = FontCache.register (font);
        }

        public Vector2 get_text_size (string text) {
            return get_text_size_ext (text, (int)size);
        }

        public Vector2 get_text_size_ext (string text, int size) {
            Raylib.Vector2 text_size = Raylib.measure_text_ext (_font, text, (float)size, spacing);

            return { text_size.x, text_size.y };
        }

        public void draw_text (string text, Vector2 position, Colour colour = Colour.WHITE) {
            Raylib.draw_text_ext (_font, text, { position.x, position.y }, size, spacing, { colour.r, colour.g, colour.b, colour.a });
        }
    }
}

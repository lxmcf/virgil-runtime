namespace Virgil.Graphics {
    public class Font {
        private Raylib.Font _font;

        public float size;
        public float spacing;

        public Font (string filename) {
            _font = Raylib.load_font (filename);

            size = (float)_font.baseSize;
            spacing = 2.0f;

            Raylib.set_texture_filter (_font.texture, Raylib.TextureFilter.POINT);
        }

        public Font.from_ttf (string filename, int size) {
            int[] characters = { };

            //  Load default character set
            _font = Raylib.load_font_ext (filename, size, characters);

            this.size = (float)size;
            spacing = 2.0f;
        }

        ~Font () {
            Raylib.unload_font (_font);
        }

        public void draw_text (string text, Vector2 position, Colour colour = Colour.WHITE) {
            Raylib.draw_text_ext (_font, text, { position.x, position.y }, size, spacing, Raylib.RED);
        }
    }
}

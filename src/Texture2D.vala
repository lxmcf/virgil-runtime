using Virgil.Runtime;

namespace Virgil {
    public class Texture2D {
        private Raylib.Texture2D _texture;

        public int width {
            get { return _texture.width; }
        }

        public int height {
            get { return _texture.height; }
        }

        public Texture2D (string filename) {
            _texture = Raylib.load_texture (filename);
        }

        public void unload () {
            Raylib.unload_texture (_texture);
        }

        public void draw (Vector2 position) {
            Raylib.draw_texture_vector (_texture, { position.x, position.y }, Raylib.WHITE);
        }

        public void draw_tint (Vector2 position, Colour colour) {
            Raylib.draw_texture_vector (_texture, { position.x, position.y }, { colour.r, colour.g, colour.b, colour.a });
        }

        public void draw_ext (Rectangle source, Rectangle destination, Vector2 origin, float rotation, Colour colour = Colour.WHITE) {
            Raylib.draw_texture_pro (
                _texture,
                { source.x, source.y, source.width, source.height},
                { destination.x, destination.y, destination.width, destination.height},
                { origin.x, origin.y },
                rotation,
                { colour.r, colour.g, colour.b, colour.a }
            );
        }

        public Rectangle get_rectangle () {
            return { 0, 0, _texture.width, _texture.height };
        }
    }
}

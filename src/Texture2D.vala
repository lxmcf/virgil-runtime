using Virgil.Runtime;

namespace Virgil {
    public class Texture2D {
        private Raylib.Texture2D _texture;

        public Point origin;

        public Texture2D (string filename) {
            _texture = Raylib.load_texture (filename);

            origin = { 0, 0 };
        }

        public void unload () {
            Raylib.unload_texture (_texture);
        }

        public void draw (Vector2 position) {
            if (get_draw_state () == DrawState.WAITING) return;

            Raylib.draw_texture_vector (_texture, { position.x, position.y }, Raylib.WHITE);
        }

        public void draw_tint (Vector2 position, Colour colour) {
            if (get_draw_state () == DrawState.WAITING) return;

            Raylib.draw_texture_vector (_texture, { position.x + origin.x, position.y + origin.y }, { colour.r, colour.g, colour.b, colour.a });
        }

        [Version (experimental = true, experimental_until = "1.0")]
        public void draw_to_transform (Transform transform) {
            if (get_draw_state () == DrawState.WAITING) return;

            Raylib.draw_texture_ext (_texture, { transform.position.x + origin.x, transform.position.y + origin.y }, transform.rotation, transform.scale, Raylib.WHITE);
        }

        public void set_origin (Point point) {
            origin = point;
        }
    }
}

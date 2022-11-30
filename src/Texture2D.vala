namespace Virgil {
    public class Texture2D {
        private Raylib.Texture2D _texture;

        public Point origin;

        public Texture2D (string filename) {
            _texture = Raylib.load_texture (filename);
        }

        ~Texture2D () {
            //  TODO: Create texture manager to free textures
        }

        public void unload () {
            Raylib.unload_texture (_texture);
        }

        public void draw (Vector2 position) {
            Raylib.draw_texture_vector (_texture, { position.x, position.y }, Raylib.WHITE);
        }

        [Version (experimental = true, experimental_until = "1.0")]
        public void draw_to_transform (Transform transform) {
            Raylib.draw_texture_ext (_texture, { transform.position.x, transform.position.y }, transform.rotation, transform.scale, Raylib.WHITE);
        }

        public void set_origin (Point point) {
            origin = point;
        }
    }
}

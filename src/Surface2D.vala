namespace Virgil {
    public class Surface2D {
        private Raylib.RenderTexture2D _texture;

        public Surface2D (int width, int height) {
            _texture = Raylib.load_render_texture (width, height);
        }

        public void draw (Vector2 position) {
            Raylib.draw_texture (_texture.texture, (int)position.x, (int)position.y, Raylib.WHITE);
        }
    }
}

namespace Virgil {
    public class RenderTexture {
        private Raylib.RenderTexture2D _render_texture;

        public int width {
            get { return _render_texture.texture.width; }
        }

        public int height {
            get { return _render_texture.texture.height; }
        }

        public RenderTexture (int width, int height) {
            _render_texture = Raylib.load_render_texture (width, height);
        }

        ~RenderTexture () {
            Raylib.unload_render_texture (_render_texture);
        }

        public void set_target () {
            Raylib.begin_texture_mode (_render_texture);
        }

        public void reset_target () {
            Raylib.end_texture_mode ();
        }

        public void draw (Vector2 position) {
            Raylib.draw_texture_vector (_render_texture.texture, { position.x, position.y }, Raylib.WHITE);
        }

        public void draw_tint (Vector2 position, Colour colour) {
            Raylib.draw_texture_vector (_render_texture.texture, { position.x, position.y }, { colour.r, colour.g, colour.b, colour.a });
        }

        public void draw_ext (Rectangle source, Rectangle destination, Vector2 origin, float rotation, Colour colour = Colour.WHITE) {
            Raylib.draw_texture_pro (
                _render_texture.texture,
                { source.x, source.y, source.width, source.height},
                { destination.x, destination.y, destination.width, destination.height},
                { origin.x, origin.y },
                rotation,
                { colour.r, colour.g, colour.b, colour.a }
            );
        }
    }
}

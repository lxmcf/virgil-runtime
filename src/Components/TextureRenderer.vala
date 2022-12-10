namespace Virgil {
    public class TextureRenderer : Component {
        private Texture2D? _texture;
        private Colour _colour;

        public override void start () {
            _colour = Colour.WHITE;
            _texture = null;
        }

        public override void draw () {
            if (_texture == null) return;
            _texture.draw_ext (
                _texture.get_rectangle (),
                { (int)transform.position.x, (int)transform.position.y, (int)(_texture.width * transform.scale.x), (int)(_texture.height * transform.scale.y) },
                { 0, 0 },
                0,
                Colour.WHITE
            );
        }

        public void set_texture (Texture2D? texture) {
            _texture = texture;
        }
    }
}

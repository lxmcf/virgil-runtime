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

            Vector2 position = object.get_relative_position ();

            Rectangle destination = {
                (int)position.x,
                (int)position.y,
                (int)(_texture.width * transform.scale.x),
                (int)(_texture.height * transform.scale.y)
            };

            _texture.draw_ext (
                _texture.get_rectangle (),
                destination,
                { 0, 0 },
                0,
                _colour
            );
        }

        public void set_texture (Texture2D? texture) {
            _texture = texture;
        }
    }
}

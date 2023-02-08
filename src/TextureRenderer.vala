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

            Vector2 position = object.relative_transform.position;

            Rectangle destination = {
                (int)position.x,
                (int)position.y,
                (int)(_texture.width * object.relative_transform.scale.x),
                (int)(_texture.height * object.relative_transform.scale.y)
            };

            _texture.draw_ext (
                _texture.get_rectangle (),
                destination,
                { _texture.origin.x, _texture.origin.y },
                object.relative_transform.rotation,
                _colour
            );

            //  _texture.draw (position);
        }

        public void set_texture (Texture2D? texture) {
            _texture = texture;
        }

        public int get_texture_width () {
            if (_texture == null) return 0;

            return _texture.width;
        }

        public int get_texture_height () {
            if (_texture == null) return 0;

            return _texture.height;
        }
    }
}

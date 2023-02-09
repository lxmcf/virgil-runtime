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

            Vector2 adjusted_origin = Vector2.multiply (_texture.origin, object.relative_transform.scale);
            float adjusted_width = _texture.width * object.relative_transform.scale.x;
            float adjusted_height = _texture.height * object.relative_transform.scale.y;

            Rectangle destination = { position.x, position.y, adjusted_width, adjusted_height };

            _texture.draw_ext (
                _texture.get_rectangle (),
                destination,
                adjusted_origin,
                object.relative_transform.rotation,
                _colour
            );
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

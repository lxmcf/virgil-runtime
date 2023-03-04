namespace Virgil {
    public class TextureRenderer2D : Component {
        private Texture2D? _texture;
        private Animation2D? _animation;

        private Colour _colour;

        public override void start () {
            _colour = Colour.WHITE;

            //  TODO: Remove null from the equation and move to 'defaults'
            _texture = null;
            _animation = null;
        }

        public override void update () {
            if (_animation == null) return;

            _animation.play ();
        }

        public override void draw () {
            if (_texture == null) return;

            Vector2 position = object.relative_transform.position;

            if (_animation == null) {
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
            } else {
                Vector2 adjusted_origin = Vector2.multiply (_animation.get_pivot (), object.relative_transform.scale);

                Rectangle adjusted_target = _animation.get_current_frame_rectange ();
                adjusted_target.x = position.x;
                adjusted_target.y = position.y;

                adjusted_target = Rectangle.scale_vector (adjusted_target, object.relative_transform.scale);

                _texture.draw_ext (
                    _animation.get_current_frame_rectange (),
                    adjusted_target,
                    adjusted_origin,
                    object.relative_transform.rotation,
                    _colour
                );
            }
        }

        public void set_texture (Texture2D? texture) {
            _texture = texture;
        }

        public void set_animation (Animation2D? animation) {
            _animation = animation;

            //  Reset animation on assign
            if (_animation != null) {
                _animation.set_current_frame (0);
            }
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

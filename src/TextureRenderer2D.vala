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

            Vector2 position = object.world_transform.position;
            Rectangle destination = { position.x, position.y, 0.0f, 0.0f };

            Rectangle source;
            Vector2 origin;

            if (_animation == null) {
                source = _texture.get_rectangle ();

                origin = Vector2.multiply (_texture.origin, object.world_transform.scale);

                destination.width = _texture.width * object.world_transform.scale.x;
                destination.height = _texture.height * object.world_transform.scale.y;
            } else {
                source = _animation.get_current_frame_rectange ();
                origin = Vector2.multiply (_animation.origin, object.world_transform.scale);

                destination = _animation.get_current_frame_rectange ();
                destination.x = position.x;
                destination.y = position.y;

                destination = Rectangle.scale_vector (destination, object.world_transform.scale);
            }

            _texture.draw_ext (
                source,
                destination,
                origin,
                object.world_transform.rotation,
                _colour
            );
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

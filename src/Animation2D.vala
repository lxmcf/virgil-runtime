namespace Virgil {
    public class Animation2D {
        private Rectangle[] _frames;
        private float _current_frame;
        private float _speed;

        public Vector2 origin;

        public int frame_count {
            get { return _frames.length; }
        }

        public Animation2D (Rectangle[] frames, float speed = 10.0f) {
            _frames = frames;
            _speed = speed;

            this.origin = { frames[0].width / 2, frames[0].height / 2 };

            _current_frame = 0;
        }

        public Animation2D.from_texture (Texture2D texture, int frame_width, int frame_height, float speed = 10.0f) {
            int count = texture.width / frame_width;

            for (int i = 0; i < count; i++) {
                Rectangle rectangle = { i * frame_width, 0, frame_width, frame_height };

                _frames += rectangle;
            }

            _speed = speed;
            origin = { frame_width / 2, frame_height / 2 };
        }

        public Animation2D.from_rectangle (Rectangle bounds, int frame_width, int frame_height, float speed = 10.0f) {
            int count = (int)bounds.width / frame_width;

            for (int i = 0; i < count; i++) {
                Rectangle rectangle = { i * frame_width, 0, frame_width, frame_height };

                _frames += rectangle;
            }

            _speed = speed;
            origin = { frame_width / 2, frame_height / 2 };
        }

        public void play () {
            _current_frame += (_speed * Raylib.get_frame_time ());
            _current_frame = _current_frame % _frames.length;
        }

        public void set_frames (Rectangle[] frames) {
            _frames = frames;
        }

        public void set_current_frame (int frame) {
            _current_frame = frame;
        }

        public void set_speed (float speed) {
            _speed = speed;
        }

        public Rectangle get_current_frame_rectange () {
            return _frames[(int)_current_frame];
        }
    }
}

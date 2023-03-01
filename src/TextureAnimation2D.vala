namespace Virgil {
    internal class TextureAnimation2D {
        private Rectangle[] _frames;
        private float _current_frame;

        public int current_frame;
        public float speed;

        public int frame_count {
            get { return _frames.length; }
        }

        public TextureAnimation2D (Rectangle[] frames, float speed) {
            _frames = frames;

            _current_frame = 0;
        }

        public TextureAnimation2D.from_texture (Texture2D texture, int frame_width, int frame_height) {
            int count = texture.width / frame_width;

            for (int i = 0; i < count; i++) {
                Rectangle rectangle = { i * frame_width, 0, frame_width, frame_height };

                _frames += rectangle;
            }
        }

        public void set_frames (Rectangle[] frames) {
            _frames = frames;
        }

        public void set_current_frame (int index) {

        }
    }
}

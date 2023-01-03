namespace Virgil {
    public class Camera2D : Component {
        private Raylib.Camera2D _camera;

        private GameObject? _target;

        public override void start () {
            _camera = { };
            _camera.rotation = 0.0f;
            _camera.zoom = 1.0f;
            _camera.target = { 0.0f, 0.0f };

            Rectangle window = Game.get_window_rectangle ();

            _camera.offset = { window.width / 2, window.height / 2 };
        }

        public override void update () {
            if (_target != null) {
                _camera.target = {
                    _target.relative_transform.position.x,
                    _target.relative_transform.position.y
                };
            }
        }

        public override void begin_draw () {
            Raylib.begin_mode_2D (_camera);
        }

        public override void end_draw () {
            Raylib.end_mode_2D ();
        }

        public void set_offset (Vector2 offset) {
            _camera.offset = { offset.x, offset.y };
        }

        public void set_target (GameObject? target) {
            _target = target;
        }

        public void set_zoom (float zoom) {
            _camera.zoom = zoom;
        }
    }
}

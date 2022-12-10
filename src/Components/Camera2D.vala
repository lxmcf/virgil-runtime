namespace Virgil {
    public class Camera2D : Component {
        private Raylib.Camera2D _camera;

        private GameObject? _target;

        public Camera2D () {
            _camera = { };
            _camera.rotation = 0.0f;
            _camera.zoom = 1.0f;
            _camera.target = { 0.0f, 0.0f };
        }

        public override void update () {
            if (_target != null) {
                _camera.target = {
                    _target.transform.position.x ,
                    _target.transform.position.y
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
    }
}

namespace Virgil {
    public class Camera2D : Component {
        private Raylib.Camera2D _camera;

        private GameObject? _target;

        public Vector2 offset {
            get { return { _camera.offset.x, _camera.offset.y }; }
            set { _camera.offset = { value.x, value.y }; }
        }

        public Vector2 position {
            get { return { _camera.target.x, _camera.target.y }; }
            set { _camera.target = { value.x, value.y }; }
        }

        public float zoom {
            get { return _camera.zoom; }
            set { _camera.zoom = value; }
        }

        public override void start () {
            _camera.rotation = 0.0f;
            _camera.zoom = 1.0f;
            _camera.target = { 0.0f, 0.0f };

            _target = object;
        }

        public override void update () {
            if (_target != null) {
                _camera.target.x = _target.world_transform.position.x;
                _camera.target.y = _target.world_transform.position.y;
            }
        }

        public override void begin_draw () {
            Raylib.begin_mode_2D (_camera);
        }

        public override void end_draw () {
            Raylib.end_mode_2D ();
        }

        public void set_target (GameObject? target) {
            _target = target;
        }

        public Vector2 get_mouse_position () {
            Vector2 mouse = Input.get_mouse_position ();

            mouse = Vector2.divide_value (mouse, _camera.zoom);

            return Vector2.add (position, mouse);
        }
    }
}

namespace Virgil {
    public class Camera2D : Component {
        private Raylib.Camera2D _camera;

        private Camera2D () {
            _camera.target = { transform.position.x, transform.position.y };
            _camera.offset = { 0.0f, 0.0f };
            _camera.rotation = 0.0f;
            _camera.zoom = 1.0f;
        }

        public override void start () {

        }

        public override void update () {

        }

        public void set_offset (Vector2 offset) {

        }
    }
}

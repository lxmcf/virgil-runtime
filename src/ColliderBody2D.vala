namespace Virgil {
    public class ColliderBody2D {
        private ColliderShape2D _shape;
        private unowned GameObject _object;

        //  Circle
        private float _radius;

        //  Rectangle
        private Vector2[] _transformed_vertices;
        private Vector2[] _vertices;

        public Vector2 size;
        public Vector2 position {
            get { return _object.relative_transform.position; }
        }

        public ColliderBody2D (ColliderShape2D shape, GameObject object) {
            _shape = shape;
            _object = object;

            if (_shape == ColliderShape2D.CIRCLE) {
                _radius = 8.0f;
            } else {
                size = { 16.0f, 16.0f };

                float left = -size.x / 2.0f;
                float right = left + size.x;

                float top = -size.y / 2.0f;
                float bottom = top + size.y;

                _vertices = new Vector2[4];
                _vertices[0] = { left, top };
                _vertices[1] = { right, top };
                _vertices[2] = { right, bottom };
                _vertices[3] = { left, bottom };

                _transformed_vertices = _vertices;
            }

            Virgil.Runtime.Collision.global_scene.register_collider (this);
        }

        public void move (Vector2 vector) {
            _object.transform.position = Vector2.add (position, vector);
        }

        public void set_size (Vector2 vector) {
            size = vector;

            float left = -size.x / 2.0f;
            float right = left + size.x;

            float top = -size.y / 2.0f;
            float bottom = top + size.y;

            _vertices[0] = { left, top };
            _vertices[1] = { right, top };
            _vertices[2] = { right, bottom };
            _vertices[3] = { left, bottom };
        }

        public inline ColliderShape2D get_shape () {
            return _shape;
        }

        public Vector2[] get_transformed_vertices () {
            for (int i = 0; i < _vertices.length; i++) {
                Vector2 scaled_vertex = Vector2.multiply (_vertices[i], _object.relative_transform.scale);

                _transformed_vertices[i] = Vector2.transform (scaled_vertex, _object.relative_transform);
            }

            return _transformed_vertices;
        }

        public float get_transformed_radius () {
            return _radius * Math.fmaxf (_object.relative_transform.scale.x, _object.relative_transform.scale.y);
        }

        public void draw () {
            if (_shape == ColliderShape2D.RECTANGLE) {
                draw_polygon_outline (get_transformed_vertices ());
            } else {
                draw_circle_outline (_object.relative_transform.position, get_transformed_radius ());
            }
        }
    }
}

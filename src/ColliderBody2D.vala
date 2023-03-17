namespace Virgil {
    public class ColliderBody2D {
        private ColliderShape2D _shape;
        private unowned Collider2D _collider;

        //  Circle
        private float _radius;

        //  Rectangle
        private Vector2[] _transformed_vertices;
        private Vector2[] _vertices;
        private Vector2 _size;

        public Vector2 position {
            get { return _collider.object.relative_transform.position; }
        }

        public unowned Collider2D collider {
            get { return _collider; }
        }

        public ColliderBody2D (ColliderShape2D shape, Collider2D collider) {
            _shape = shape;
            _collider = collider;

            if (_shape == ColliderShape2D.CIRCLE) {
                _radius = 8.0f;
            } else {
                _size = { 16.0f, 16.0f };

                float left = -_size.x / 2.0f;
                float right = left + _size.x;

                float top = -_size.y / 2.0f;
                float bottom = top + _size.y;

                _vertices = new Vector2[4];
                _vertices[0] = { left, top };
                _vertices[1] = { right, top };
                _vertices[2] = { right, bottom };
                _vertices[3] = { left, bottom };

                _transformed_vertices = _vertices;
            }
        }

        public void move (Vector2 vector) {
            _collider.object.transform.position = Vector2.add (position, vector);
        }

        public void set_size (Vector2 vector) {
            _size = vector;

            float left = -_size.x / 2.0f;
            float right = left + _size.x;

            float top = -_size.y / 2.0f;
            float bottom = top + _size.y;

            _vertices[0] = { left, top };
            _vertices[1] = { right, top };
            _vertices[2] = { right, bottom };
            _vertices[3] = { left, bottom };
        }

        public void set_radius (float radius) {
            _radius = radius;
        }

        public inline ColliderShape2D get_shape () {
            return _shape;
        }

        public Vector2[] get_transformed_vertices () {
            for (int i = 0; i < _vertices.length; i++) {
                Vector2 scaled_vertex = Vector2.multiply (_vertices[i], _collider.object.relative_transform.scale);

                _transformed_vertices[i] = Vector2.transform (scaled_vertex, _collider.object.relative_transform);
            }

            return _transformed_vertices;
        }

        public float get_transformed_radius () {
            return _radius * Math.fmaxf (_collider.object.relative_transform.scale.x, _collider.object.relative_transform.scale.y);
        }

        public void draw () {
            if (_shape == ColliderShape2D.RECTANGLE) {
                draw_polygon_outline (get_transformed_vertices ());
            } else {
                draw_circle_outline (_collider.object.relative_transform.position, get_transformed_radius ());
            }
        }
    }
}

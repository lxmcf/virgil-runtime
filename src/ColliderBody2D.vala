namespace Virgil {
    public class ColliderBody2D {
        private ColliderShape2D _shape;
        private unowned Collider2D _collider;

        internal bool update_vertices;

        public Colour debug_colour;

        //  Circle
        private float _radius;

        //  Rectangle
        private Vector2[] _transformed_vertices;
        private Vector2[] _vertices;
        private Vector2 _size;


        public Vector2 position {
            get { return _collider.object.world_transform.position; }
        }

        public unowned Collider2D collider {
            get { return _collider; }
        }

        public ColliderBody2D (ColliderShape2D shape, Collider2D collider) {
            _shape = shape;
            _collider = collider;

            debug_colour = Colour.WHITE;

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

            update_vertices = true;
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
            if (update_vertices) {
                float cos = Math.cosf (_collider.object.world_transform.rotation * Raylib.DEG2RAD);
                float sin = Math.sinf (_collider.object.world_transform.rotation * Raylib.DEG2RAD);

                float rotation_x;
                float rotation_y;

                for (int i = 0; i < _vertices.length; i++) {
                    Vector2 scaled_vertex = Vector2.multiply (_vertices[i], _collider.object.world_transform.scale);

                    rotation_x = (cos * scaled_vertex.x) - (sin * scaled_vertex.y);
                    rotation_y = (sin * scaled_vertex.x) + (cos * scaled_vertex.y);

                    _transformed_vertices[i] = Vector2.add ({ rotation_x, rotation_y }, _collider.object.world_transform.position);
                }

                update_vertices = false;
            }

            return _transformed_vertices;
        }

        public float get_transformed_radius () {
            return _radius * Math.fmaxf (_collider.object.world_transform.scale.x, _collider.object.world_transform.scale.y);
        }

        public void draw () {
            if (_shape == ColliderShape2D.RECTANGLE) {
                draw_polygon_outline (get_transformed_vertices (), debug_colour);
            } else {
                draw_circle_outline (_collider.object.world_transform.position, get_transformed_radius (), debug_colour);
            }
        }
    }
}

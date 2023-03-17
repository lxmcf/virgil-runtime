namespace Virgil.Runtime {
    internal class CollisionScene {
        private static static List<ColliderBody2D> _active_colliders;
        private static bool update_collision;

        internal static void init () {
            _active_colliders = new List<ColliderBody2D> ();

            update_collision = true;
        }

        internal static void update () {
            if (_active_colliders.length () == 0) return;

            for (int i = 0; i < _active_colliders.length () - 1; i++) {
                if (!update_collision) break;

                ColliderBody2D body1 = _active_colliders.nth_data (i);

                for (int j = i + 1; j < _active_colliders.length (); j++) {
                    if (!update_collision) break;

                    ColliderBody2D body2 = _active_colliders.nth_data (j);

                    //  TODO: Impliment AABB checking
                    //  TODO: Impliment quad tree's or something?
                    //  TODO: Move collision type checks to bit flags
                    CollisionData collide_check = _check_collisions (body1, body2);
                    if (collide_check.collision_found) {
                        if (body1.collider.is_static && body2.collider.is_static) continue;

                        if (body1.collider.is_static) {
                            body2.move (Vector2.multiply_value (collide_check.normal, collide_check.depth));
                        } else if (body2.collider.is_static) {
                            body1.move (Vector2.multiply_value (collide_check.normal, -collide_check.depth));
                        } else {
                            body1.move (Vector2.multiply_value (collide_check.normal, -collide_check.depth / 2.0f));
                            body2.move (Vector2.multiply_value (collide_check.normal, collide_check.depth / 2.0f));
                        }

                        body1.collider.object.collide_2D (body2.collider);
                        if (!update_collision) break;

                        body2.collider.object.collide_2D (body1.collider);
                        if (!update_collision) break;
                    }
                }
            }

            update_collision = true;
        }

        internal static void register (ColliderBody2D body) {
            _active_colliders.append (body);
        }

        internal static void remove (ColliderBody2D body) {
            _active_colliders.remove (body);

            update_collision = false;
        }

        private static CollisionData _check_collisions (ColliderBody2D body1, ColliderBody2D body2) {
            CollisionData collision = { };

            ColliderShape2D shape1 = body1.get_shape ();
            ColliderShape2D shape2 = body2.get_shape ();

            if (shape1 == ColliderShape2D.RECTANGLE) {
                if (shape2 == ColliderShape2D.RECTANGLE) {
                    return _intersect_polygon (body1.get_transformed_vertices (), body2.get_transformed_vertices ());
                } else { // Circle
                    collision = _intersect_circle_polygon (body2.position, body2.get_transformed_radius (), body1.get_transformed_vertices ());

                    collision.normal = { -collision.normal.x, -collision.normal.y };
                    return collision;
                }
            } else { // Circle
                if (shape2 == ColliderShape2D.RECTANGLE) {
                    return _intersect_circle_polygon (body1.position, body1.get_transformed_radius (), body2.get_transformed_vertices ());
                } else { // Circle
                    return _intersect_circles (body1.position, body2.get_transformed_radius (), body2.position, body2.get_transformed_radius ());
                }
            }
        }

        private static Vector2 _get_projection_mean (Vector2[] vertices) {
            Vector2 sum = Vector2.ZERO;

            for (int i = 0; i < vertices.length; i++) {
                sum = Vector2.add (sum, vertices[i]);
            }

            sum = Vector2.divide_value (sum, vertices.length);

            return sum;
        }

        private static Vector2 _project_vertices (Vector2[] vertices, Vector2 axis) {
            Vector2 values = { float.MAX, float.MIN };

            for (int i = 0; i < vertices.length; i++) {
                float projection = Vector2.dot (vertices[i], axis);

                if (projection < values.x) { values.x = projection; }
                if (projection > values.y) { values.y = projection; }
            }

            return values;
        }

        private static Vector2 _project_circle (Vector2 position, float radius, Vector2 axis) {
            Vector2 values = { float.MAX, float.MIN };

            Vector2 direction = Vector2.normalise (axis);
            Vector2 length = Vector2.multiply_value (direction, radius);

            Vector2 point1 = Vector2.add (position, length);
            Vector2 point2 = Vector2.subtract (position, length);

            values.x = Vector2.dot (point1, axis);
            values.y = Vector2.dot (point2, axis);

            if (values.x > values.y) {
                float cache = values.x;

                values.x = values.y;
                values.y = cache;
            }

            return values;
        }

        private static CollisionData _intersect_circles (Vector2 position1, float radius1, Vector2 position2, float radius2) {
            CollisionData collision = { };

            collision.collision_found = false;
            collision.normal = Vector2.ZERO;
            collision.depth = 0f;

            float distance = Vector2.distance (position1, position2);
            float radii = radius1 + radius2;

            if (distance >= radii) return collision;

            collision.normal = Vector2.subtract (position2, position1);
            collision.normal = Vector2.normalise (collision.normal);

            collision.depth = radii - distance;
            collision.collision_found = true;

            return collision;
        }

        private static CollisionData _intersect_polygon (Vector2[] vertices1, Vector2[] vertices2) {
            CollisionData collision = { };

            collision.collision_found = false;

            collision.normal = Vector2.ZERO;
            collision.depth = float.MAX;

            for (int i = 0; i < vertices1.length; i++) {
                Vector2 vertex1 = vertices1[i];
                Vector2 vertex2 = vertices1[(i + 1) % vertices1.length];

                Vector2 edge = Vector2.subtract (vertex2, vertex1);
                Vector2 axis = { -edge.y, edge.x };
                axis = Vector2.normalise (axis);

                Vector2 value1 = _project_vertices (vertices1, axis);
                Vector2 value2 = _project_vertices (vertices2, axis);

                if (value1.x >= value2.y || value2.x >= value1.y) return collision;

                float axis_depth = Math.fminf (value2.y - value1.x, value1.y - value2.x);

                if (axis_depth < collision.depth) {
                    collision.depth = axis_depth;
                    collision.normal = axis;
                }
            }

            for (int i = 0; i < vertices2.length; i++) {
                Vector2 vertex1 = vertices2[i];
                Vector2 vertex2 = vertices2[(i + 1) % vertices2.length];

                Vector2 edge = Vector2.subtract (vertex2, vertex1);
                Vector2 axis = { -edge.y, edge.x };
                axis = Vector2.normalise (axis);

                Vector2 value1 = _project_vertices (vertices1, axis);
                Vector2 value2 = _project_vertices (vertices2, axis);

                if (value1.x >= value2.y || value2.x >= value1.y) return collision;

                float axis_depth = Math.fminf (value2.y - value1.x, value1.y - value2.x);

                if (axis_depth < collision.depth) {
                    collision.depth = axis_depth;
                    collision.normal = axis;
                }
            }

            Vector2 pivot1 = _get_projection_mean (vertices1);
            Vector2 pivot2 = _get_projection_mean (vertices2);

            Vector2 direction = Vector2.subtract (pivot2, pivot1);

            if (Vector2.dot (direction, collision.normal) < 0.0f) {
                collision.normal = { -collision.normal.x, -collision.normal.y };
            }

            collision.collision_found = true;
            return collision;
        }

        private static CollisionData _intersect_circle_polygon (Vector2 position, float radius, Vector2[] vertices) {
            CollisionData collision = { };

            collision.collision_found = false;
            collision.normal = Vector2.ZERO;
            collision.depth = float.MAX;

            Vector2 axis;

            float axis_depth;

            for (int i = 0; i < vertices.length; i++) {
                Vector2 vertex1 = vertices[i];
                Vector2 vertex2 = vertices[(i + 1) % vertices.length];

                Vector2 edge = Vector2.subtract (vertex2, vertex1);
                axis = { -edge.y, edge.x };
                axis = Vector2.normalise (axis);

                Vector2 value1 = _project_vertices (vertices, axis);
                Vector2 value2 = _project_circle (position, radius, axis);

                if (value1.x >= value2.y || value2.x >= value1.y) return collision;

                axis_depth = Math.fminf (value2.y - value1.x, value1.y - value2.x);

                if (axis_depth < collision.depth) {
                    collision.depth = axis_depth;
                    collision.normal = axis;
                }
            }

            int point_index = _point_on_polygon (position, vertices);
            Vector2 closest_point = vertices[point_index];

            axis = Vector2.subtract (closest_point, position);
            axis = Vector2.normalise (axis);

            Vector2 value1 = _project_vertices (vertices, axis);
            Vector2 value2 = _project_circle (position, radius, axis);

            if (value1.x >= value2.y || value2.x >= value1.y) return collision;

            axis_depth = Math.fminf (value2.y - value1.x, value1.y - value2.x);

            if (axis_depth < collision.depth) {
                collision.depth = axis_depth;
                collision.normal = axis;
            }

            Vector2 polygon_center = _get_projection_mean (vertices);

            Vector2 direction = Vector2.subtract (polygon_center, position);

            if (Vector2.dot (direction, collision.normal) < 0.0f) {
                collision.normal = { -collision.normal.x, -collision.normal.y };
            }

            collision.collision_found = true;
            return collision;
        }

        private static int _point_on_polygon (Vector2 position, Vector2[] vertices) {
            int result = -1;
            float minimum_distance = float.MAX;

            for (int i = 0; i < vertices.length; i++) {
                Vector2 vertex = vertices[i];
                float distance = Vector2.distance (vertex, position);

                if (distance < minimum_distance) {
                    minimum_distance = distance;
                    result = i;
                }
            }

            return result;
        }
    }
}

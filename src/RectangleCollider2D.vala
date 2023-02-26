namespace Virgil {
    public class RectangleCollider2D : Collider2D {
        public Vector2 size;
        public Vector2 adjusted_size { public get; private set; }

        public override void setup () {
            size = {
                64.0f,
                64.0f
            };

            offset = {
                size.x / 2.0f,
                size.y / 2.0f
            };

            shape = ColliderShape2D.RECTANGLE;
        }

        public override bool process_collision (Collider2D collider) {
            switch (collider.shape) {
                case ColliderShape2D.RECTANGLE:
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_rectangles (
                        { rectangle.position.x, rectangle.position.y, rectangle.adjusted_size.x, rectangle.adjusted_size.y },
                        { position.x, position.y, adjusted_size.x, adjusted_size.y }
                    );

                case ColliderShape2D.CIRCLE:
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle (
                        { circle.position.x, circle.position.y }, circle.adjusted_radius,   // Cirle
                        { position.x, position.y, adjusted_size.x, adjusted_size.y }        // Rectangle
                    );

                default:
                    break;
            }

            return false;
        }

        public override void adjust_collider () {
            adjusted_size = Vector2.multiply (size, object.relative_transform.scale);
            adjusted_size = Vector2.abs (adjusted_size);
        }

        public override void draw () {
            draw_rectangle_outline ({ position.x, position.y, adjusted_size.x, adjusted_size.y }, debug_colour);
        }
    }
}

namespace Virgil {
    public class RectangleCollider2D : Collider2D {
        public Vector2 size;

        public override void setup () {
            size = {
                64.0f,
                64.0f
            };

            offset = {
                size.x / 2.0f,
                size.y / 2.0f
            };
        }

        public override bool process_collision (Collider2D collider) {
            //  TODO: Remove strings and replace with enums
            switch (collider.name) {
                case "VirgilRectangleCollider2D":
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_rectangles (
                        { rectangle.position.x, rectangle.position.y, rectangle.size.x, rectangle.size.y },
                        { position.x, position.y, size.x, size.y }
                    );

                case "VirgilCircleCollider2D":
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle (
                        { circle.position.x, circle.position.y }, circle.radius,    // Cirle
                        { position.x, position.y, size.x, size.y }                  // Rectangle
                    );
            }

            return false;
        }

        public override void draw () {
            draw_rectangle_outline ({ position.x, position.y, size.x, size.y }, _colour);
        }
    }
}

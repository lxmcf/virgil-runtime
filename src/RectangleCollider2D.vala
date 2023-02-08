namespace Virgil {
    public class RectangleCollider2D : Collider2D {
        public int width { get; private set; }
        public int height { get; private set; }

        public override void setup () {
            width = 64;
            height = 64;

            offset = {
                (float)width / 2.0f,
                (float)height / 2.0f
            };
        }

        public override bool process_collision (Collider2D collider) {
            //  TODO: Remove strings and replace with enums
            switch (collider.name) {
                case "VirgilRectangleCollider2D":
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_rectangles (
                        { (int)rectangle.position.x, (int)rectangle.position.y, rectangle.width, rectangle.height },
                        { (int)position.x, (int)position.y, width, height }
                    );

                case "VirgilCircleCollider2D":
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle ({ circle.position.x, circle.position.y }, circle.radius, { (int)position.x, (int)position.y, width, height });
            }

            return false;
        }

        public override void draw () {
            draw_rectangle_outline ({ (int)position.x, (int)position.y, width, height }, _colour);
        }
    }
}

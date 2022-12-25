namespace Virgil {
    public class RectangleCollider2D : Collider2D {
        public int width { get; private set; }
        public int height { get; private set; }

        public override void setup () {
            width = 64;
            height = 64;
        }

        public override bool process_collision (Collider2D collider) {
            string collider_type = Type.from_instance (collider).name ();

            if (collider is RectangleCollider2D)

            switch (collider_type) {
                case "VirgilRectangleCollider2D":
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_rectangles (
                        { (int)rectangle.position.x, (int)rectangle.position.y, rectangle.width, rectangle.height },
                        { (int)position.x, (int)position.y, width, height }
                    );

                case "VirgilCircleCollider2D":
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle ({ circle.position.x, circle.position.y }, circle.radius, { (int)transform.position.x, (int)transform.position.y, width, height });
            }

            return false;
        }

        public override void draw () {
            Vector2 position = object.get_relative_position ();

            draw_rectangle_outline ({ (int)position.x, (int)position.y, width, height }, _colour);
        }
    }
}

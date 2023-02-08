namespace Virgil {
    public class CircleCollider2D : Collider2D {
        public float radius { get; private set; }

        public override void setup () {
            radius = 32.0f;
        }

        public override bool process_collision (Collider2D collider) {
            switch (collider.name) {
                case "VirgilRectangleCollider2D":
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle ({ position.x, position.y }, radius, { rectangle.position.x, rectangle.position.y, rectangle.width, rectangle.height });


                case "VirgilCircleCollider2D":
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circles ({ position.x, position.y }, radius, { circle.position.x, circle.position.y }, circle.radius);
            }

            return false;
        }

        public override void draw () {
            draw_circle_outline (position, radius, _colour);
        }
    }
}

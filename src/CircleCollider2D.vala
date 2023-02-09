namespace Virgil {
    public class CircleCollider2D : Collider2D {
        public float radius;
        public float adjusted_radius { public get; private set; }

        public override void setup () {
            radius = 32.0f;
            adjusted_radius = radius;
        }

        public override bool process_collision (Collider2D collider) {
            switch (collider.name) {
                case "VirgilRectangleCollider2D":
                    RectangleCollider2D rectangle = (RectangleCollider2D)collider;

                    return Raylib.check_collision_circle_rectangle (
                        { position.x, position.y }, adjusted_radius,                                                                     // Circle
                        { rectangle.position.x, rectangle.position.y, rectangle.adjusted_size.x, rectangle.adjusted_size.y }    // Rectangle
                    );


                case "VirgilCircleCollider2D":
                    CircleCollider2D circle = (CircleCollider2D)collider;

                    return Raylib.check_collision_circles (
                        { position.x, position.y }, adjusted_radius,
                        { circle.position.x, circle.position.y }, circle.adjusted_radius
                    );
            }

            return false;
        }

        public override void adjust_collider () {
            adjusted_radius = Math.fabsf (radius * Math.fmaxf (object.relative_transform.scale.x, object.relative_transform.scale.y));
        }

        public override void draw () {
            draw_circle_outline (position, adjusted_radius, _colour);
        }
    }
}

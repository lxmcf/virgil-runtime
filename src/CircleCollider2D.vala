namespace Virgil {
    public class CircleCollider2D : Collider2D {
        public override void setup () {
            register_collider (new ColliderBody2D (ColliderShape2D.CIRCLE, this));
        }

        public void set_radius (float radius) {
            collider.set_radius (radius);
        }
    }
}

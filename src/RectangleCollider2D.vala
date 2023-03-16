namespace Virgil {
    public class RectangleCollider2D : Collider2D {
        public override void setup () {
            register_collider (new ColliderBody2D (ColliderShape2D.RECTANGLE, this));
        }

        public void set_size (Vector2 size) {
            collider.set_size (size);
        }
    }
}

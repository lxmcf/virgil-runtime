using Virgil.Runtime;

namespace Virgil {
    public class Collider2D : Component {
        protected unowned ColliderBody2D? collider;

        public bool is_static;

        ~Collider2D () {
            if (collider == null) return;

            CollisionScene.remove (collider);
        }

        public override void start () {
            is_static = false;

            setup ();
        }

        public override void end_draw () {
            collider.draw ();
        }

        protected void register_collider (ColliderBody2D body) {
            collider = body;

            CollisionScene.register (body);
        }

        //  FIXME: Not final
        public virtual void setup () { }
    }
}

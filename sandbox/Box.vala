using Virgil;

namespace Sandbox {
    public class Box : GameObject {
        public override void start () {
            add_component (new RectangleCollider2D ());

            transform.translate ({ 128.0f, 128.0f });
        }
    }
}

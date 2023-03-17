using Virgil;

namespace Sandbox {
    public class Tree : GameObject {
        public override void start () {
            RectangleCollider2D collider = add_component_return<RectangleCollider2D> (new RectangleCollider2D ());
            collider.set_size ({ 16.0f, 8.0f });
            collider.is_static = true;
        }
    }
}

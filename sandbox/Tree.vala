using Virgil;

namespace Sandbox {
    public class Tree : GameObject {
        private ColliderBody2D _test_collider_body;

        public override void start () {
            _test_collider_body = new ColliderBody2D (ColliderShape2D.RECTANGLE, this);
            _test_collider_body.set_size ({ 16.0f, 8.0f });
        }
    }
}

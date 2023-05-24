using Virgil;

namespace Sandbox {
    public class TestObject : GameObject {
        public override void start () {
            local_transform.translate ({
                Random.int_range (0, 640),
                Random.int_range (0, 360)
            });
        }

        public override void draw () {
            draw_circle (position, 16, Colour.RED);
        }
    }
}

using Virgil;

namespace Sandbox {
    public class Box : GameObject {
        public override void start () {
            add_component (new TextureRenderer ());

            TextureRenderer tr = get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            transform.translate ({ 128.0f, 128.0f });
        }

        public override void update (float delta_time) {
            GameObject test = get_root_parent ();

            print ("Root: %s\n", test.name);
        }
    }
}

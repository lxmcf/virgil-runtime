using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Box : GameObject {
        public override void start () {
            add_component (new TextureRenderer2D ());

            TextureRenderer2D tr = get_component<TextureRenderer2D> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            transform.translate ({ 128.0f, 128.0f });
        }
    }
}

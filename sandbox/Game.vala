using Virgil;

namespace Sandbox {
    public class TestGame : Game {
        Texture2D tree_texture;

        public override void start () {
            tree_texture = new Texture2D ("data/sprites/tree.png");
            tree_texture.origin.y = tree_texture.height - 8;

            root.add_child (new Player ());
            root.transform.scale = Vector2.multiply_value (root.transform.scale, 3.0f);

            for (int i = 0; i < 5; i++) {
                int x = Random.int_range (0, 640);
                int y = Random.int_range (0, 360);

                GameObject tree = root.add_child (new GameObject ());
                tree.transform.position = { x, y };

                TextureRenderer2D tr = tree.add_component_return<TextureRenderer2D> (new TextureRenderer2D ());

                tr.set_texture (tree_texture);
            }
        }

        public override void update (float delta_time) {
            root.sort_children ((object1, object2)=>{
                return (int)object1.transform.position.y - (int)object2.transform.position.y;
            });
        }

        public override void draw () { }
    }
}

//  TODO: Need to wrap 'Module' into Virgil to remove need for gmodule dependency
[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

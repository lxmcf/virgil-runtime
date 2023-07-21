using Virgil;
using Virgil.Input;
using Virgil.Shell;
using Virgil.Graphics;
using Virgil.GUI;

namespace Sandbox {
    public class TestGame : Game {
        public Texture2D tree_texture;
        public Shader shader;

        public bool active;

        public override void start () {
            shader = new Shader.from_file ("data/shaders/test_greyscale.glsl");

            tree_texture = new Texture2D ("data/sprites/tree.png");
            tree_texture.origin.y = tree_texture.height - 4;

            Player player = root.add_child_return<Player> (new Player ());
            root.scale = Vector2.multiply_value (root.scale, 3.0f);

            Camera2D camera = root.add_component_return<Camera2D> (new Camera2D ());
            camera.set_target (player);
            camera.offset = { 320, 180 };

            for (int i = 0; i < 5; i++) {
                int x = Random.int_range (64, 576);
                int y = Random.int_range (64, 296);

                Tree tree = root.add_child_return<Tree> (new Tree ());
                tree.position = { x, y };

                TextureRenderer2D tr = tree.add_component_return<TextureRenderer2D> (new TextureRenderer2D ());
                tr.set_texture (tree_texture);
            }

            set_window_title ("Sandbox");
        }

        public override void update (float delta_time) {
            root.sort_children ((object1, object2) => {
                return (int)object1.position.y - (int)object2.position.y;
            });

            if (check_key (KeyCode.CHAR_E)) {
                root.transform.rotation += 10.0f * delta_time;
            }

            if (check_key (KeyCode.CHAR_Q)) {
                root.transform.rotation -= 10.0f * delta_time;
            }

            int xaxis = check_key_raw (KeyCode.RIGHT) - check_key_raw (KeyCode.LEFT);
            int yaxis = check_key_raw (KeyCode.DOWN) - check_key_raw (KeyCode.UP);

            if (xaxis != 0 || yaxis != 0) {
                float direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                root.transform.translate (Vector2.length_direction (200.0f * delta_time, direction));
            }
        }

        public override void begin_draw () {
            //  shader.set_target_shader ();
        }

        public override void draw () {
            toggle ({ 8, 32, 48, 24 }, ref active);
        }

        public override void end_draw () {
            //  shader.reset_target_shader ();
        }
    }
}

//  TODO: Need to wrap 'Module' into Virgil to remove need for gmodule dependency
[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

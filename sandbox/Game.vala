using Virgil;
using Virgil.Input;
using Virgil.Graphics;

namespace Sandbox {
    public class TestGame : Game {
        GameObject root;

        float direction;

        public override void start () {
            root = new GameObject ();

            root.add_component (new TextureRenderer ());

            TextureRenderer tr = root.get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            root.transform.position = { 32.0f, 32.0f };
            root.add_child (new Player ());
        }

        public override void update (float delta_time) {
            root.update_object ();

            int xaxis = (int)check_key (KeyCode.CHAR_D) - (int)check_key (KeyCode.CHAR_A);
            int yaxis = (int)check_key (KeyCode.CHAR_S) - (int)check_key (KeyCode.CHAR_W);

            int rotate = (int)check_key (KeyCode.CHAR_E) - (int)check_key (KeyCode.CHAR_Q);
            int scale = (int)check_key (KeyCode.CHAR_Z) - (int)check_key (KeyCode.CHAR_X);

            if (xaxis != 0 || yaxis != 0) {
                direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                root.transform.translate (Vector2.length_direction (200.0f * delta_time, direction));
            }

            if (rotate != 0) {
                root.transform.rotation += (100.0f * delta_time) * rotate;
            }

            if (scale != 0) {
                root.transform.scale.x += (5.0f * delta_time) * scale;
                root.transform.scale.y += (5.0f * delta_time) * scale;
            }
        }

        public override void draw () {
            root.draw_object ();
        }
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

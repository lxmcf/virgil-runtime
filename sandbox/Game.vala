using Virgil;
using Virgil.Input;
using Virgil.Graphics;

namespace Sandbox {
    public class TestGame : Game {
        float direction;

        Font test_font;

        public override void start () {
            root.add_component (new TextureRenderer ());
            root.add_component (new RectangleCollider2D ());

            TextureRenderer tr = root.get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            root.transform.position = { 32.0f, 32.0f };
            root.add_child (new Player ());

            test_font = new Font.from_ttf ("data/font.ttf", 16);
        }

        public override void update (float delta_time) {
            int xaxis = check_key_raw (KeyCode.CHAR_D) - check_key_raw (KeyCode.CHAR_A);
            int yaxis = check_key_raw (KeyCode.CHAR_S) - check_key_raw (KeyCode.CHAR_W);

            int rotate = check_key_raw (KeyCode.CHAR_E) - check_key_raw (KeyCode.CHAR_Q);
            int scale = check_key_raw (KeyCode.CHAR_Z) - check_key_raw (KeyCode.CHAR_X);

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
            test_font.draw_text ("Hello world!", Vector2.ZERO);
        }
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

using Virgil;
using Virgil.Input;
using Virgil.Graphics;
using Virgil.Audio;

namespace Sandbox {
    public class TestGame : Game {
        float direction;

        Font test_font;
        Sound test_sound;

        public override void start () {
            root.add_component (new TextureRenderer2D ());
            root.add_component (new CircleCollider2D ());

            TextureRenderer2D tr = root.get_component<TextureRenderer2D> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            Camera2D camera = root.add_component_return<Camera2D> (new Camera2D ());
            camera.set_target (root);

            root.transform.position = { 32.0f, 32.0f };
            root.add_child (new Player ());

            test_font = new Font.from_ttf ("data/font.ttf", 16);
            test_sound = new Sound ("data/sound.ogg");
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

            if (check_key_pressed (KeyCode.BACKSPACE)) {
                test_sound.play ();
            }

            Vector2 mouse = get_mouse_position ();

            print ("Mouse: [ %f | %f ]\n", mouse.x, mouse.y);
        }

        public override void draw () {
            test_font.draw_text ("Hello world!", Vector2.ZERO);
        }
    }
}

//  TODO: Need to wrap 'Module' into Virgil to remove need for gmodule dependency
[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

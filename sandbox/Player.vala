using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Player : GameObject {
        public float speed;
        float direction;

        public override void start () {
            speed = 200.0f;

            transform.translate ({ 128.0f, 0.0f });

            add_component (new TextureRenderer ());
            add_component (new RectangleCollider2D ());

            TextureRenderer tr = get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            add_child (new Box ());
        }

        public override void update (float delta_time) {
            int xaxis = (int)check_key (KeyCode.RIGHT) - (int)check_key (KeyCode.LEFT);
            int yaxis = (int)check_key (KeyCode.DOWN) - (int)check_key (KeyCode.UP);

            int rotate = (int)check_key (KeyCode.CHAR_P) - (int)check_key (KeyCode.CHAR_O);
            int scale = (int)check_key (KeyCode.CHAR_M) - (int)check_key (KeyCode.CHAR_N);

            if (xaxis != 0 || yaxis != 0) {
                direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                transform.translate (Vector2.length_direction (speed * delta_time, direction));
            }

            if (rotate != 0) {
                transform.rotation += (100.0f * delta_time) * rotate;

                print ("Rotation: %f\n", transform.rotation);
            }

            if (scale != 0) {
                transform.scale.x += (5.0f * delta_time) * scale;
                transform.scale.y += (5.0f * delta_time) * scale;
            }
        }
    }
}

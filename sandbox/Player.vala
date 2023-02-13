using Virgil;
using Virgil.Input;
using Virgil.Graphics;

namespace Sandbox {
    public class Player : GameObject {
        public float speed;
        float direction;

        public override void start () {
            speed = 200.0f;

            transform.translate ({ 128.0f, 0.0f });

            add_component (new TextureRenderer ());
            add_component (new CircleCollider2D ());

            TextureRenderer tr = get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_square.png"));

            add_child (new Box ());
        }

        public override void update (float delta_time) {
            int xaxis = check_key_raw (KeyCode.RIGHT) - check_key_raw (KeyCode.LEFT);
            int yaxis = check_key_raw (KeyCode.DOWN) - check_key_raw (KeyCode.UP);

            int rotate = check_key_raw (KeyCode.CHAR_P) - check_key_raw (KeyCode.CHAR_O);
            int scale = check_key_raw (KeyCode.CHAR_M) - check_key_raw (KeyCode.CHAR_N);

            if (xaxis != 0 || yaxis != 0) {
                direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                transform.translate (Vector2.length_direction (speed * delta_time, direction));
            }

            if (rotate != 0) {
                transform.rotation += (100.0f * delta_time) * rotate;
            }

            if (scale != 0) {
                transform.scale.x += (5.0f * delta_time) * scale;
                transform.scale.y += (5.0f * delta_time) * scale;
            }
        }
    }
}

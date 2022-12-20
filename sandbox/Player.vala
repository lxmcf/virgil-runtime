using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Player : GameObject {
        public float speed;

        public override void start () {
            speed = 200.0f;

            add_component (new TextureRenderer ());
            add_component (new CircleCollider2D ());

            TextureRenderer tr = get_component<TextureRenderer> ();
            tr.set_texture (new Texture2D ("data/sprites/test_planet.png"));
        }

        public override void update (float delta_time) {
            int xaxis = (int)check_key (KeyCode.CHAR_D) - (int)check_key (KeyCode.CHAR_A);
            int yaxis = (int)check_key (KeyCode.CHAR_S) - (int)check_key (KeyCode.CHAR_W);

            Vector2 movement_vector = { (xaxis * speed) * delta_time, (yaxis * speed) * delta_time };

            transform.translate (movement_vector);
        }

        public override void draw () { }
    }
}

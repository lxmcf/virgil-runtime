using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Player : GameObject {
        public Texture2D texture;
        public float speed;

        public override void start () {
            texture = new Texture2D ("data/sprites/test_planet.png");

            speed = 200.0f;

            add_component (new TextureRenderer ());

            TextureRenderer tr = get_component<TextureRenderer> ();
            tr.set_texture (texture);
        }

        public override void update (float delta_time) {
            int xaxis = (int)check_key (KeyCode.CHAR_D) - (int)check_key (KeyCode.CHAR_A);
            int yaxis = (int)check_key (KeyCode.CHAR_S) - (int)check_key (KeyCode.CHAR_W);

            transform.position = Vector2.add (transform.position, { (xaxis * speed) * delta_time, (yaxis * speed) * delta_time });
        }
    }
}

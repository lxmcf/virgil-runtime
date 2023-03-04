using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Player : GameObject {
        public Texture2D texture;
        public Animation2D animation;

        public float speed;

        public override void start () {
            texture = new Texture2D ("data/sprites/walk_down.png");
            animation = new Animation2D.from_texture (texture, 16, 16);
            animation.origin.y = texture.height;

            speed = 200.0f;

            TextureRenderer2D tr = add_component_return<TextureRenderer2D> (new TextureRenderer2D ());
            tr.set_texture (texture);
            tr.set_animation (animation);
        }

        public override void update (float delta_time) {
            int xaxis = check_key_raw (KeyCode.RIGHT) - check_key_raw (KeyCode.LEFT);
            int yaxis = check_key_raw (KeyCode.DOWN) - check_key_raw (KeyCode.UP);

            if (xaxis != 0 || yaxis != 0) {
                float direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                transform.translate (Vector2.length_direction (speed * delta_time, direction));
            }
        }
    }
}

using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class Player : GameObject {
        public Texture2D texture;
        public Animation2D animation;

        public float speed;

        public override void start () {
            CircleCollider2D collider = add_component_return<CircleCollider2D> (new CircleCollider2D ());
            collider.set_radius (8.0f);
            collider.is_static = false;

            texture = new Texture2D ("data/sprites/walk_down.png");
            animation = new Animation2D.from_texture (texture, 16, 16);
            animation.origin.y = texture.height;

            speed = 200.0f;

            TextureRenderer2D tr = add_component_return<TextureRenderer2D> (new TextureRenderer2D ());
            tr.set_texture (texture);
            tr.set_animation (animation);

            transform.translate ({ 320, 180 });
        }

        public override void update (float delta_time) {
            int xaxis = check_key_raw (KeyCode.CHAR_D) - check_key_raw (KeyCode.CHAR_A);
            int yaxis = check_key_raw (KeyCode.CHAR_S) - check_key_raw (KeyCode.CHAR_W);

            if (xaxis != 0 || yaxis != 0) {
                float direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                transform.translate (Vector2.length_direction (speed * delta_time, direction));
            }

            if (check_key (KeyCode.SPACE)) {
                transform.scale = Vector2.add_value (transform.scale, delta_time);
            }

            if (check_key (KeyCode.CHAR_R)) {
                transform.rotation += delta_time * 100.0f;
            }
        }

        public override void collide_2D (Collider2D collider) {
            //  destroy (collider.object);
        }
    }
}

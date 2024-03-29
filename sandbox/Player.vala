using Virgil;
using Virgil.Input;
using Virgil.Graphics;

namespace Sandbox {
    public class Player : GameObject {
        private TextureRenderer2D _renderer;

        public Texture2D[] textures;
        public Animation2D animation;

        public float speed;

        public override void start () {
            RectangleCollider2D collider = add_component_return<RectangleCollider2D> (new RectangleCollider2D ());
            collider.set_size ({ 8.0f, 8.0f });

            textures = new Texture2D[4];
            textures[0] = new Texture2D ("data/sprites/walk_right.png");
            textures[1] = new Texture2D ("data/sprites/walk_up.png");
            textures[2] = new Texture2D ("data/sprites/walk_left.png");
            textures[3] = new Texture2D ("data/sprites/walk_down.png");

            animation = new Animation2D.from_texture (textures[0], 16, 16);
            animation.origin.y = textures[0].height;

            speed = 200.0f;

            _renderer = add_component_return<TextureRenderer2D> (new TextureRenderer2D ());
            _renderer.set_texture (textures[3]);
            _renderer.set_animation (animation);

            transform.translate ({ 320, 180 });
        }

        public override void update (float delta_time) {
            int xaxis = check_key_raw (KeyCode.CHAR_D) - check_key_raw (KeyCode.CHAR_A);
            int yaxis = check_key_raw (KeyCode.CHAR_S) - check_key_raw (KeyCode.CHAR_W);

            if (xaxis != 0 || yaxis != 0) {
                float direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                int axis = (int)direction / 90;

                _renderer.set_texture (textures[axis]);

                transform.translate (Vector2.length_direction (speed * delta_time, direction));
            }

            if (check_key (KeyCode.SPACE)) {
                scale = Vector2.add_value (scale, delta_time);
            }

            if (check_key (KeyCode.CHAR_R)) {
                rotation += delta_time * 100.0f;
            }
        }
    }
}

using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class TestGame : Game {
        Texture2D test_texture;

        Vector2 position;
        float speed;

        public override void start () {
            test_texture = new Texture2D ("data/sprites/test_planet.png");

            position = Vector2 (0.0f, 0.0f);
            speed = 200.0f;
        }

        public override void update (float delta_time) {
            int xaxis = (int)check_key (KeyCode.CHAR_D) - (int)check_key (KeyCode.CHAR_A);
            int yaxis = (int)check_key (KeyCode.CHAR_S) - (int)check_key (KeyCode.CHAR_W);

            position = Vector2.add (position, { (xaxis * speed) * delta_time, (yaxis * speed) * delta_time });
        }

        public override void draw () {
            test_texture.draw (position);
        }
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

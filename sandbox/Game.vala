using Virgil;
using Virgil.Input;
using Virgil.Graphics;

namespace Sandbox {
    public class TestGame : Game {
        GameObject root;

        float direction;

        public override void start () {
            root = new GameObject ();
            root.add_component (new RectangleCollider2D ());

            root.transform.position = { 32.0f, 32.0f };

            root.add_child (new Player ());
            root.add_child (new Box ());
        }

        public override void update (float delta_time) {
            root.update_object ();

            int xaxis = (int)check_key (KeyCode.RIGHT) - (int)check_key (KeyCode.LEFT);
            int yaxis = (int)check_key (KeyCode.DOWN) - (int)check_key (KeyCode.UP);

            if (xaxis != 0 || yaxis != 0) {
                direction = Vector2.direction ({ 0.0f, 0.0f }, { xaxis, yaxis });

                root.transform.translate (Vector2.length_direction (200.0f * delta_time, direction));
            }
        }

        public override void draw () {
            root.draw_object ();
        }
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

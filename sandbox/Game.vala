using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class TestGame : Game {
        GameObject player;

        public override void start () {
            player = new GameObject ();

            player.transform.position = { 32.0f, 32.0f };

            player.add_child (new Player ());
        }

        public override void update (float delta_time) {
            player.update_object ();
        }

        public override void draw () {
            player.draw_object ();
        }
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

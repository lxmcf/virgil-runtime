using Virgil;
using Virgil.Input;

namespace Sandbox {
    public class TestGame : Game {
        Player player;

        public override void start () {
            player = new Player ();
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

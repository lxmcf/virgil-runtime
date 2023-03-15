using Virgil;

namespace Sandbox {
    public class TestGame : Game {
        public override void start () {
            root.add_child (new Player ());
            root.transform.scale = Vector2.multiply_value (root.transform.scale, 3.0f);
        }
    }
}

//  TODO: Need to wrap 'Module' into Virgil to remove need for gmodule dependency
[ModuleInit]
public Type register_game (Module module) {
    return typeof (Sandbox.TestGame);
}

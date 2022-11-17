namespace Virgil.Engine {
    internal errordomain GameRegisterError {
        NOT_SUPPORTED,
        UNEXPECTED_TYPE,
        NO_REGISTRATION_FUNCTION,
        FAILED,

        NO_GAME_REGISTERED // UNUSED
    }

    [CCode (has_target = false)]
    private delegate Type RegisterGameFunction (Module module);

    internal class GameLoader {
        private Game? _registered_game;
        private Module? _module;

        private bool _did_register;

        public GameLoader () {
            _registered_game = null;
            _module = null;

            _did_register = false;
        }

        public void register (string file) throws GameRegisterError {
            bool supported = Module.supported ();

            if (!supported) {
                throw new GameRegisterError.NOT_SUPPORTED ("Modules are not supported");
            }

            Module game_module = Module.open (GLib.Environment.get_current_dir () + "/" + file, ModuleFlags.MASK);
            if (game_module == null) {
                throw new GameRegisterError.FAILED (Module.error ());
            }

            void* method;
            string method_name = "register_game";

            game_module.symbol (method_name, out method);
            if (method == null) {
                throw new GameRegisterError.NO_REGISTRATION_FUNCTION (method_name + " not found!");
            }

            RegisterGameFunction register_game = (RegisterGameFunction)method;
            Type type = register_game (game_module);
            if (!type.is_a (typeof (Game))) {
                throw new GameRegisterError.UNEXPECTED_TYPE (type.name () + " is not a valid game type!");
            }

            Game game = (Game)Object.new (type);

            _registered_game = game;
            _module = (owned)game_module;

            _did_register = true;

            game.init ();
        }

        public void run (float delta_time) {
            if (!_did_register) return;

            _registered_game.update (delta_time);

            _registered_game.draw ();
        }

        public void load_content () {
            if (!_did_register) return;

            _registered_game.load_content ();
        }

        public void unload_content () {
            if (!_did_register) return;

            _registered_game.unload_content ();
        }
    }
}

namespace Virgil.Runtime {
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

            _module = Module.open (GLib.Environment.get_current_dir () + "/" + file, ModuleFlags.MASK);
            if (_module == null) {
                throw new GameRegisterError.FAILED (Module.error ());
            }

            void* method;
            string method_name = "register_game";

            _module.symbol (method_name, out method);
            if (method == null) {
                throw new GameRegisterError.NO_REGISTRATION_FUNCTION (method_name + " not found!");
            }

            RegisterGameFunction register_game = (RegisterGameFunction)method;
            Type type = register_game (_module);
            if (!type.is_a (typeof (Game))) {
                throw new GameRegisterError.UNEXPECTED_TYPE (type.name () + " is not a valid game type!");
            }

            _registered_game = (Game)Object.new (type);

            _did_register = true;

            _registered_game.do_start ();
        }

        public void run (float delta_time) {
            if (!_did_register) return;

            _registered_game.do_update (delta_time);
        }

        public void draw () {
            if (!_did_register) return;

            _registered_game.do_draw ();
        }
    }
}

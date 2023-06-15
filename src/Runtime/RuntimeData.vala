namespace Virgil.Runtime {
    public class RuntimeConfig {
        private static RuntimeConfig _config;

        //  Flags
        public bool show_version { get; internal set; }
        public bool show_fps { get; internal set; }
        public bool show_build_info { get; internal set; }

        //  Physics
        public bool disable_physics { get; internal set; }
        public int physics_steps { get; internal set; }

        //  Files
        public string working_directory { get; internal set; }
        public string game_file { get; internal set; }

        //  Targets
        public int target_fps { get; internal set; }

        internal RuntimeConfig () {
            //  Flags
            show_version = false;
            show_fps = false;
            show_build_info = false;

            //  Physics
            disable_physics = false;
            physics_steps = 8;

            //  Files
            working_directory = "";
#if VIRGIL_PLATFORM_WINDOWS
            game_file = "game.dll";
#else
            game_file = "game.so";
#endif

            //  Targets
            target_fps = -1;
        }

        public static RuntimeConfig get_default () {
            return _config = new RuntimeConfig ();
        }

        public static unowned RuntimeConfig get_config () {
            return _config;
        }
    }
}

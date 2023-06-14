namespace Virgil.Runtime {
    //  TODO: Rework for when engine modules are added to allow custom runtime arguments
    //  TODO: Refactor entirely, this is very dirty
    private class RuntimeConfig {
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

        }

        public static RuntimeConfig get_default () {
            return new RuntimeConfig ();
        }
    }

    internal class RuntimeData {
        //  Flags
        public static bool show_version;
        public static bool show_fps;
        public static bool show_build_info;

        //  Physics
        public static bool disable_physics;
        public static int physics_steps;

        //  Files
        public static string working_directory;
        public static string game_file;

        //  Targets
        public static int target_fps;

        public const OptionEntry[] OPTIONS = {
            //  Flags
            { "version", '\0', OptionFlags.NONE, OptionArg.NONE, ref show_version, "Display version number", null },
            { "show-fps", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref show_fps, "Show FPS in game", null },
            { "build-info", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref show_build_info, "Display engine build info", null },

            //  Physics
            { "disable-physics", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref disable_physics, "Disable internal physics engine", null },
            { "phyics-steps", '\0', OptionFlags.HIDDEN, OptionArg.INT, ref physics_steps, "Physics steps per frame", "STEPS" },

            //  Files
            { "directory", 'd', OptionFlags.FILENAME, OptionArg.FILENAME, ref working_directory, "Set working directory", "DIRECTORY" },
            { "game", 'g', OptionFlags.FILENAME, OptionArg.FILENAME, ref game_file, "Load game file", "FILE" },

            //  Targets
            { "target-fps", 't', OptionFlags.NONE, OptionArg.INT, ref target_fps, "Set target framerate cap", "FPS" },

            { null }
        };

        private const OptionEntry[] OPTIONS_TEST = {
            { "test", '\0', OptionFlags.NONE, OptionArg.NONE, null, "This is a test", null },
            { null }
        };

        public static void init_default () {
#if VIRGIL_PLATFORM_WINDOWS
            game_file = "game.dll";
#else
            game_file = "game.so";
#endif

            working_directory = "";
            target_fps = -1;

            physics_steps = 8;
        }

        public static bool parse_arguments (ref unowned string[] arguments) {
            OptionGroup group = new OptionGroup ("Test", "Test description", "test help description");
            group.add_entries (OPTIONS_TEST);

            try {
                OptionContext opt_context = new OptionContext ("- Virgil Game Engine");

                opt_context.set_help_enabled (true);
                opt_context.add_main_entries (OPTIONS, null);
                opt_context.add_group (group);
                opt_context.parse (ref arguments);

                return true;
            } catch (OptionError e) {
                printerr ("error: %s\n", e.message);
                printerr ("Run '%s --help' to see a full list of available command line options.\n", arguments[0]);

                return false;
            }
        }
    }
}

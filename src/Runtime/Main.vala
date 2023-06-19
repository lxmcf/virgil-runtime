namespace Virgil.Runtime {
    private static bool _show_version;
    private static bool _show_fps;
    private static bool _show_build_info;
    private static bool _disable_physics;
    private static int _physics_steps;
    private static string _working_directory;
    private static string _game_file;
    private static int _target_fps;

    private const OptionEntry[] OPTIONS = {
        { "version", '\0', OptionFlags.NONE, OptionArg.NONE, ref _show_version, "Display version number", null },
        { "show-fps", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref _show_fps, "Show FPS in game", null },
        { "build-info", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref _show_build_info, "Display engine build info", null },

        { "disable-physics", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref _disable_physics, "Disable internal physics engine", null },
        { "phyics-steps", '\0', OptionFlags.HIDDEN, OptionArg.INT, ref _physics_steps, "Physics steps per frame", "STEPS" },

        { "directory", 'd', OptionFlags.NONE, OptionArg.FILENAME, ref _working_directory, "Set working directory", "DIRECTORY" },
        { "game", 'g', OptionFlags.NONE, OptionArg.FILENAME, ref _game_file, "Load game file", "FILE" },

        { "target-fps", 't', OptionFlags.NONE, OptionArg.INT, ref _target_fps, "Set target framerate cap", "FPS" },

        { null }
    };

    internal static int main (string[] args) {
        RuntimeConfig config = _init_config ();

        try {
            OptionContext opt_context = new OptionContext ("- Virgil Game Engine");

            opt_context.set_help_enabled (true);
            opt_context.add_main_entries (OPTIONS, null);
            opt_context.parse (ref args);
        } catch (OptionError e) {
            printerr ("error: %s\n", e.message);
            printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        }

        _apply_config (ref config);

        if (config.show_version) {
            print ("Virgil %s\n", "DEVEL");

            return 0;
        }

        Raylib.set_trace_log_level (Raylib.TraceLogLevel.NONE);

        Window window = new Window ("Virgil Runtime", 640, 360);
        GameLoader current_game = new GameLoader ();

        if (config.target_fps > 0) {
            Raylib.set_target_fps (config.target_fps);
        }

        CollisionScene.init ();

        //----------------------------------------------------------------------------------
        // Game loading
        //----------------------------------------------------------------------------------
        try {
            current_game.register (config.working_directory + "/" + config.game_file);
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

        //----------------------------------------------------------------------------------
        // Main loop
        //----------------------------------------------------------------------------------
        while (!window.should_close () || Game.should_close) {
            current_game.run (Raylib.get_frame_time ());

            CollisionScene.update ();

            window.clear ();

            current_game.draw ();

            if (config.show_fps) {
                Raylib.draw_fps (8, 8);
            }

            window.present ();
        }

        return 0;
    }

    private RuntimeConfig _init_config () {
        RuntimeConfig config = new RuntimeConfig ();

        _show_version = config.show_version;
        _show_fps = config.show_fps;
        _show_build_info = config.show_build_info;
        _disable_physics = config.disable_physics;
        _physics_steps = config.physics_steps;
        _working_directory = config.working_directory;
        _game_file = config.game_file;
        _target_fps = config.target_fps;

        return config;
    }

    private void _apply_config (ref RuntimeConfig config) {
        config.show_version = _show_version;
        config.show_fps = _show_fps;
        config.show_build_info = _show_build_info;
        config.disable_physics = _disable_physics;
        config.physics_steps = _physics_steps;
        config.working_directory = _working_directory;
        config.game_file = _game_file;
        config.target_fps = _target_fps;
    }

    private void _handle_command_line (ref string arguments) {

    }
}

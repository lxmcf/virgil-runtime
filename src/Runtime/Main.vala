namespace Virgil.Runtime {
    internal static int main (string[] args) {
        RuntimeConfig? config = handle_command_line (args);

        if (config == null) { return 1; }

        if (config.show_version) {
            print ("Virgil %s\n", RUNTIME_VERSION);

            return 0;
        }

        if (config.show_build_info) {
            //  NOTE: Need to add more information
            print ("%s\n", RUNTIME_BUILD_INFO);

            return 0;
        }

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

    internal RuntimeConfig? handle_command_line (string[] arguments) {
        bool show_version = false;
        bool show_fps = false;
        bool show_build_info = false;

        string working_directory = "";
        string game_file = RUNTIME_GAME_FILE;

        int target_fps = -1;

        OptionEntry[] cli_entry = {
            { "version", '\0', OptionFlags.NONE, OptionArg.NONE, ref show_version, "Display version number", null },
            { "show-fps", '\0', OptionFlags.NONE, OptionArg.NONE, ref show_fps, "Show FPS in game", null },
            { "build-info", '\0', OptionFlags.NONE, OptionArg.NONE, ref show_build_info, "Display build info", null },

            { "directory", 'd', OptionFlags.NONE, OptionArg.FILENAME, ref working_directory, "Set working directory", "DIRECTORY" },
            { "game", 'g', OptionFlags.NONE, OptionArg.FILENAME, ref game_file, "Load game file", "FILE" },

            { "target-fps", 't', OptionFlags.NONE, OptionArg.INT, ref target_fps, "Set target framerate cap", "FPS" },

            { null }
        };

        try {
            OptionContext opt_context = new OptionContext ("- Virgil Game Engine");

            opt_context.set_help_enabled (true);
            opt_context.add_main_entries (cli_entry, null);
            opt_context.parse (ref arguments);
        } catch (OptionError e) {
            printerr ("error: %s\n", e.message);
            printerr ("Run '%s --help' to see a full list of available command line options.\n", arguments[0]);

            return null;
        }

        RuntimeConfig config = {
            //  Flags
            show_version,
            show_fps,
            show_build_info,

            //  Files
            working_directory,
            game_file,

            //  Targets
            target_fps
        };

        return config;
    }
}

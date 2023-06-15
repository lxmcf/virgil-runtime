namespace Virgil.Runtime {
    internal static int main (string[] args) {
        RuntimeConfig config = RuntimeConfig.get_default ();
        CommandLineIndex command_line_index = new CommandLineIndex ("virgil", "virgil help");

        init_command_line (ref command_line_index, ref config);

        try {
            OptionContext opt_context = new OptionContext ("- Virgil Game Engine");

            warning ("%d", command_line_index.get_entries ().length);

            opt_context.set_help_enabled (true);
            opt_context.add_main_entries (command_line_index.get_entries (), null);
            opt_context.parse (ref args);
        } catch (OptionError e) {
            printerr ("error: %s\n", e.message);
            printerr ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
        }

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

        try {
            current_game.register (config.working_directory + "/" + config.game_file);
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

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

    internal void init_command_line (ref CommandLineIndex cli, ref RuntimeConfig config) {
        bool show_version = config.show_version;
        bool show_fps = config.show_fps;
        bool show_build_info = config.show_build_info;
        bool disable_physics = config.disable_physics;
        int physics_steps = config.physics_steps;
        string working_directory = config.working_directory;
        string game_file = config.game_file;
        int target_fps = config.target_fps;

        cli.add_entry ({ "version", '\0', OptionFlags.NONE, OptionArg.NONE, ref show_version, "Display version number", null });
        cli.add_entry ({ "show-fps", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref show_fps, "Show FPS in game", null });
        cli.add_entry ({ "build-info", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref show_build_info, "Display engine build info", null });

        //  Physics
        cli.add_entry ({ "disable-physics", '\0', OptionFlags.HIDDEN, OptionArg.NONE, ref disable_physics, "Disable internal physics engine", null });
        cli.add_entry ({ "phyics-steps", '\0', OptionFlags.HIDDEN, OptionArg.INT, ref physics_steps, "Physics steps per frame", "STEPS" });

        //  Files
        cli.add_entry ({ "directory", 'd', OptionFlags.NONE, OptionArg.FILENAME, ref working_directory, "Set working directory", "DIRECTORY" });
        cli.add_entry ({ "game", 'g', OptionFlags.NONE, OptionArg.FILENAME, ref game_file, "Load game file", "FILE" });

        //  Targets
        cli.add_entry ({ "target-fps", 't', OptionFlags.NONE, OptionArg.INT, ref target_fps, "Set target framerate cap", "FPS" });

        config.show_version = show_version;
        config.show_fps = show_fps;
        config.show_build_info = show_build_info;
        config.disable_physics = disable_physics;
        config.physics_steps = physics_steps;
        config.working_directory = working_directory;
        config.game_file = game_file;
        config.target_fps = target_fps;
    }
}

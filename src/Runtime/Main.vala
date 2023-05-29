namespace Virgil.Runtime {
    internal static int main (string[] args) {
        Raylib.set_trace_log_level (Raylib.TraceLogLevel.ALL);

        Window window = new Window ("Virgil Runtime", 640, 360);

        GameLoader current_game = new GameLoader ();

        CollisionScene.init ();

        Raylib.Font font = Raylib.load_font ("data/fonts/pixantiqua.fnt");

        string game_prefix = "";

        // NOTE: not final, might be worth using OptionEntry
        for (int i = 0; i < args.length; i++) {
            if (args[i] == "--test-build") game_prefix = "build/";
        }

        try {
#if VIRGIL_PLATFORM_WINDOWS // TODO: Need to work out something cleaner and global
            current_game.register (game_prefix + "game.dll");
#else
            current_game.register (game_prefix + "game.so");
#endif
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

        while (!window.should_close () || Game.should_close) {
            current_game.run (Raylib.get_frame_time ());

            CollisionScene.update ();

            window.clear ();

            current_game.draw ();

            Raylib.draw_fps (8, 8);

            window.present ();
        }

        return 0;
    }
}

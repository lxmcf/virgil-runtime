namespace Virgil.Runtime {
    internal static int main (string[] args) {
        Raylib.set_trace_log_level (Raylib.TraceLogLevel.ALL);

        Window window = new Window ("Virgil Runtime", 640, 360);

        GameLoader current_game = new GameLoader ();

        FontCache.init ();
        AudioCache.init ();

        CollisionScene.init ();

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

        current_game.load_content ();

        while (!window.should_close () || Game.should_close) {
            current_game.run (Raylib.get_frame_time ());

            CollisionScene.update ();

            window.clear ();

            current_game.draw ();

            Raylib.draw_fps (8, 8);

            window.present ();
        }

        current_game.unload_content ();

        FontCache.clear ();
        AudioCache.clear ();

        window.close ();

        return 0;
    }
}

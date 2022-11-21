using Raylib;

namespace Virgil.Engine {
    internal static int main (string[] args) {
        set_trace_log_level (Raylib.TraceLogLevel.ALL);

        Window window = new Window ("Virgil Runtime", 640, 360);

        GameLoader current_game = new GameLoader ();
        SceneManager scene = new SceneManager ();

        string game_prefix = "";

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

        while (!window.should_close ()) {
            window.clear ();

            //  MAIN UPDATE LOOP
            current_game.run (get_frame_time ());
            scene.run (get_frame_time ());

            window.present ();
        }

        current_game.unload_content ();

        window.close ();

        return 0;
    }
}

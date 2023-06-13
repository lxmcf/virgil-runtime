namespace Virgil.Runtime {
    internal static int main (string[] args) {
        RuntimeData.init_default ();

        if (!RuntimeData.parse_arguments (ref args)) return 1;

        if (RuntimeData.show_version) {
            print ("Virgil %s\n", "DEVEL");

            return 0;
        }

        Raylib.set_trace_log_level (Raylib.TraceLogLevel.ALL);

        Window window = new Window ("Virgil Runtime", 640, 360);
        GameLoader current_game = new GameLoader ();

        if (RuntimeData.target_fps > 0) {
            Raylib.set_target_fps (RuntimeData.target_fps);
        }

        CollisionScene.init ();

        try {
            current_game.register (RuntimeData.working_directory + "/" + RuntimeData.game_file);
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

        while (!window.should_close () || Game.should_close) {
            current_game.run (Raylib.get_frame_time ());

            CollisionScene.update ();

            window.clear ();

            current_game.draw ();

            if (RuntimeData.show_fps) {
                Raylib.draw_fps (8, 8);
            }

            window.present ();
        }

        return 0;
    }
}

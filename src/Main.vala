namespace Virgil.Engine {
    internal static int main (string[] args) {
        SDL.Hint.set_hint (SDL.Hint.VIDEO_DRIVER, "x11"); /* Temp */

        SDL.init (SDL.InitFlag.VIDEO);

        Window window = new Window ("Virgil Runtime", 640, 360);

        GameLoader loader = new GameLoader ();
        InputManager input = new InputManager ();

        float last_frame_time = 0.0f;
        float current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;

        try {
#if WINDOWS // TODO: Need to work out something cleaner and global
            loader.register_game ("game.dll");
#else
            loader.register_game ("game.so");
#endif

            loader.init_game ();
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

        loader.load_game_content ();

        // TODO: Create time manager class
        while (!window.should_close ()) {
            current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;

            window.poll_events ();

            //  MAIN UPDATE LOOP
            loader.update_game (current_frame_time - last_frame_time);

            //  MAIN RENDER LOOP
            loader.draw_game ();

            window.present ();

            last_frame_time = current_frame_time;
        }

        loader.unload_game_content ();

        SDL.quit ();

        return 0;
    }
}
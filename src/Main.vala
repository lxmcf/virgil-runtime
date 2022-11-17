namespace Virgil.Engine {
    internal static int main (string[] args) {
        //  SDL.Hint.set_hint (SDL.Hint.VIDEO_DRIVER, "x11"); /* Temp */

        SDL.init (SDL.InitFlag.VIDEO);

        Window window = new Window ("Virgil Runtime", 640, 360);

        GameLoader current_game = new GameLoader ();
        InputManager input = new InputManager ();
        SceneManager scene = new SceneManager ();

        EventManager event = new EventManager (window, input);

        float last_frame_time = 0.0f;
        float current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;

        try {
#if VIRGIL_PLATFORM_WINDOWS // TODO: Need to work out something cleaner and global
            current_game.register ("game.dll");
#else
            current_game.register ("game.so");
#endif
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }
        current_game.load_content ();

        // TODO: Create time manager class
        while (!window.should_close ()) {
            current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;

            window.clear ();
            event.poll ();

            //  MAIN UPDATE LOOP
            current_game.run (current_frame_time - last_frame_time);
            scene.run (current_frame_time - last_frame_time);

            window.present ();

            last_frame_time = current_frame_time;
        }

        current_game.unload_content ();

        window.close ();

        SDL.quit ();

        return 0;
    }
}

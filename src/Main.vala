namespace Virgil.Engine {
    internal static int main (string[] args) {
        SDL.Hint.set_hint (SDL.Hint.VIDEO_DRIVER, "x11"); /* Temp */

        SDL.init (SDL.InitFlag.VIDEO);

        Window window = new Window (args[0], 640, 360, 0, SDL.Video.RendererFlags.ACCELERATED);

        GameLoader loader = new GameLoader ();
        InputManager input = new InputManager ();

        float last_frame_time = 0.0f;
        float current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;

        try {
            loader.register_game ("game.so");

            loader.init_game ();
        } catch (GameRegisterError e) {
            warning ("%s\n", e.message);
        }

        loader.load_game_content ();

        while (!window.should_close ()) {
            current_frame_time = (float)SDL.Timer.get_ticks () / 1000.0f;
            float delta = current_frame_time - last_frame_time;

            last_frame_time = current_frame_time;

            window.poll_events ();

            //  MAIN UPDATE LOOP
            loader.update_game (delta);

            //  MAIN RENDER LOOP
            loader.draw_game ();

            window.present ();

            SDL.Timer.delay (1); // Prevent max CPU utilisation and provide something for DT
        }

        loader.unload_game_content ();

        SDL.quit ();

        return 0;
    }
}
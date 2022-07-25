using Virgil.Runtime;

public static int main (string[] args) {
    bool running = true;
    SDL.init (SDL.InitFlag.VIDEO);

    Window window = new Window ("Hello world!", 640, 360, 0, SDL.Video.RendererFlags.ACCELERATED);

    while (running) {
        window.poll_events ();

        window.present ();
    }

    return 0;
}
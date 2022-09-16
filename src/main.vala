using Virgil.Runtime;
using Virgil.Engine;

public static int main (string[] args) {
    SDL.init (SDL.InitFlag.VIDEO);

    Window window = new Window ("Hello world!", 640, 360, 0, SDL.Video.RendererFlags.ACCELERATED);



    while (!window.should_close ()) {
        window.poll_events ();

        window.present ();
    }

    return 0;
}

public class Test1 : VirgilScript {

}

public class Test2 : VirgilScript {

}
using Raylib;

//  NOTE: leftover from SDL
namespace Virgil.Runtime {
    internal class Window {
        public Window (string title, int width, int height) {
            init_window (width, height, title);
        }

        public void close () {
            close_window ();
        }

        public void clear () {
            begin_drawing ();

            clear_background ({ 32, 32, 32, 255 });
        }

        public void present () {
            end_drawing ();
        }

        public bool should_close () {
            return window_should_close ();
        }
    }
}

using Raylib;

namespace Virgil.Engine {
    internal class Window {
        private bool _should_close;
        private string _title;

        public Window (string title, int width, int height) {
            init_window (width, height, title);

            _should_close = false;
            _title = title;
        }

        public void close () {
            close_window ();
        }

        public void clear () {
            clear_background ({ 60, 60, 60, 255 });

            begin_drawing ();
        }

        public void present () {
            end_drawing ();
        }

        public bool should_close () {
            return _should_close || window_should_close ();
        }
    }
}

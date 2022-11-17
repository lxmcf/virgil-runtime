// TODO: Remove class and move into main execution point
namespace Virgil.Engine {
    internal class Window {
        //  Singleton
        private static Window? _instance;
        public static Window instance {
            get {
                if (_instance != null) {
                    return _instance;
                } else {
                    _instance = new Window ("Virgil Runtime", 640, 360);
                    return _instance;
                }
            }
        }

        public SDL.Video.Window? sdl_window;
        public SDL.Video.Renderer? sdl_renderer;

        private bool _should_close;
        private string _title;

        public Window (string title, int width, int height) {
            sdl_window = new SDL.Video.Window (title, SDL.Video.Window.POS_CENTERED, SDL.Video.Window.POS_CENTERED, width, height, 0);
            if (sdl_window == null) {
                error ("%s", SDL.get_error ());
            }

            sdl_renderer = new SDL.Video.Renderer (sdl_window, -1, SDL.Video.RendererFlags.ACCELERATED);
            if (sdl_renderer == null) {
                error ("%s", SDL.get_error ());
            }

            _should_close = false;
            _title = title;

            _instance = this;
        }

        public void close () {
            sdl_renderer.destroy ();
            sdl_window.destroy ();
        }

        public void clear () {
            sdl_renderer.clear ();
        }

        public void present () {
            sdl_renderer.present ();
        }

        public bool should_close () {
            return _should_close;
        }

        public void set_should_close (bool should_close) {
            _should_close = should_close;
        }
    }
}

// TODO: Remove class and move into main execution point
// TODO: Split event handling to and event manager

namespace Virgil.Engine {
    internal class Window {
        public SDL.Video.Window? sdl_window;
        public SDL.Video.Renderer? sdl_renderer;

        private SDL.Event _event;

        private bool _should_close;

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
            _instance = this;
        }

        ~Window () {
            sdl_renderer.destroy ();
            sdl_window.destroy ();
        }

        // TODO: Split out into 'core' events and 'window' events
        public void poll_events () {
            sdl_renderer.clear ();

            while (SDL.Event.poll (out _event) == 1) {
                switch (_event.type) {
                    case SDL.EventType.QUIT:
                        set_should_close (true);

                        on_close ();
                    break; // QUIT

                    case SDL.EventType.MOUSEBUTTONDOWN:
                    case SDL.EventType.MOUSEBUTTONUP:
                        on_mouse_button (_event.button.x, _event.button.y, _event.button.button, _event.button.state, _event.button.clicks);
                    break; // MOUSEBUTTONDOWN && MOUSEBUTTONUP

                    case SDL.EventType.MOUSEMOTION:
                        on_mouse_cursor (_event.motion.x, _event.motion.y);
                    break; // MOUSEMOTION

                    case SDL.EventType.MOUSEWHEEL:
                        on_mouse_scroll (_event.wheel.x, _event.wheel.y);
                    break; // MOUSEWHEEL

                    case SDL.EventType.KEYDOWN:
                    case SDL.EventType.KEYUP:
                        on_key (_event.key.state, _event.key.repeat, _event.key.keysym.sym);
                    break; // KEYDOWN && KEYUP

                    case SDL.EventType.WINDOWEVENT:
                        switch (_event.window.event) {
                            case SDL.WindowEventType.MOVED:
                                on_move (_event.window.data1, _event.window.data2);
                            break; // MOVED

                            case SDL.WindowEventType.RESIZED:
                                on_resize (_event.window.data1, _event.window.data2);
                            break; // RESIZED

                            case SDL.WindowEventType.MAXIMIZED:
                            case SDL.WindowEventType.MINIMIZED:
                                on_maximise ((_event.window.event == SDL.WindowEventType.MAXIMIZED) ? true : false);
                            break; // MAXIMIZED && MINIMIZED

                            default:
                                break;
                        }
                    break; // WINDOWEVENT

                    default:
                        break;
                }
            }
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

        // TODO: Move to methods, not user facing!
        private signal void on_move (int x, int y);
        private signal void on_resize (int width, int height);
        private signal void on_close ();
        private signal void on_maximise (bool maximised);

        private signal void on_mouse_button (int x, int y, int button, int action, int clicks) {
            InputManager input_manager = InputManager.instance;

                input_manager.update_mouse_button (button, action);
        }

        private signal void on_mouse_cursor (int x, int y) {
            InputManager input_manager = InputManager.instance;

                input_manager.update_mouse_position (x, y);
        }

        private signal void on_mouse_scroll (int xscroll, int yscroll) {
            InputManager input_manager = InputManager.instance;

            input_manager.update_mouse_axis (xscroll, yscroll);
        }

        private signal void on_key (int state, int repeat, int keycode) {
            if (repeat == 0) {
                InputManager input_manager = InputManager.instance;

                input_manager.update_keyboard_key (keycode, state);
            }
        }
    }
}
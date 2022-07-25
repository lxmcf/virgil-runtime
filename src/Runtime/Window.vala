namespace Virgil.Runtime {
    internal class Window {
        public SDL.Video.Window? sdl_window;
        public SDL.Video.Renderer? sdl_renderer;

        private SDL.Event _event;

        private bool _should_close;

        public signal void on_move (int x, int y);
        public signal void on_resize (int width, int height);
        public signal void on_close ();
        public signal void on_focus (bool focused);
        public signal void on_maximise (bool maximised);

        public signal void on_mouse_button_press (int x, int y, int button, int action, int clicks);
        public signal void on_cursor_move (int x, int y);
        public signal void on_mouse_enter (bool entered);
        public signal void on_mouse_scroll (int xscroll, int yscroll);

        public signal void on_key_press (int state, int repeat, int key);

        public const int CENTERED = (int)SDL.Video.Window.POS_CENTERED;

        public Window (string title, int width, int height, uint32 window_flags, uint32 renderer_flags) {
            SDL.Video.Point position = { CENTERED, CENTERED };

            sdl_window = new SDL.Video.Window (title, position.x, position.y, width, height, window_flags);
            if (sdl_window == null) {
                printerr ("%s", SDL.get_error ());
                return;
            }

            sdl_renderer = new SDL.Video.Renderer (sdl_window, -1, renderer_flags);
            if (sdl_renderer == null) {
                printerr ("%s", SDL.get_error ());
                return;
            }
        }

        ~Window () {
            sdl_renderer.destroy ();
            sdl_window.destroy ();

            print ("Window destroyed!\n");
        }

        public void poll_events () {
            sdl_renderer.clear ();

            while (SDL.Event.poll (out _event) == 1) {
                switch (_event.type) {
                    case SDL.EventType.QUIT:
                        _should_close = true;

                        on_close ();
                    break; // QUIT

                    case SDL.EventType.MOUSEBUTTONDOWN:
                    case SDL.EventType.MOUSEBUTTONUP:
                        on_mouse_button_press (_event.button.x, _event.button.y, _event.button.button, _event.button.state, _event.button.clicks);
                    break; // MOUSEBUTTONDOWN && MOUSEBUTTONUP

                    case SDL.EventType.MOUSEMOTION:
                        on_cursor_move (_event.motion.x, _event.motion.y);
                    break; // MOUSEMOTION

                    case SDL.EventType.MOUSEWHEEL:
                        on_mouse_scroll (_event.wheel.x, _event.wheel.y);
                    break; // MOUSEWHEEL

                    case SDL.EventType.KEYDOWN:
                    case SDL.EventType.KEYUP:
                        on_key_press (_event.key.state, _event.key.repeat, _event.key.keysym.sym);
                    break; // KEYDOWN && KEYUP

                    case SDL.EventType.WINDOWEVENT:
                        switch (_event.window.event) {
                            case SDL.WindowEventType.MOVED:

                            break; // MOVED

                            case SDL.WindowEventType.RESIZED:

                            break; // RESIZED

                            case SDL.WindowEventType.FOCUS_GAINED:

                            break; // FOCUS_GAINED

                            case SDL.WindowEventType.FOCUS_LOST:

                            break; // FOCUS_LOST

                            case SDL.WindowEventType.MAXIMIZED:

                            break; // MAXIMIZED

                            case SDL.WindowEventType.MINIMIZED:

                            break; // MINIMIZED

                            case SDL.WindowEventType.ENTER:

                            break; // ENTER

                            case SDL.WindowEventType.LEAVE:

                            break; // LEAVE
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

    }
}
using Virgil.Engine;

namespace Virgil.Runtime {
    public class Window {
        private SDL.Video.Window? _sdl_window;
        private SDL.Video.Renderer? _sdl_renderer;
        private SDL.Event _event;

        private bool _should_close;

        private static Window? _instance;

        public Window (string title, int width, int height, uint32 window_flags, uint32 renderer_flags) {
            _sdl_window = new SDL.Video.Window (title, 0, 0, width, height, window_flags);
            if (_sdl_window == null) {
                printerr ("%s", SDL.get_error ());
                return;
            }

            _sdl_renderer = new SDL.Video.Renderer (_sdl_window, -1, renderer_flags);
            if (_sdl_renderer == null) {
                printerr ("%s", SDL.get_error ());
                return;
            }

            _should_close = false;
            _instance = this;
        }

        ~Window () {
            _sdl_renderer.destroy ();
            _sdl_window.destroy ();
        }

        public Window? get_instance () {
            return _instance;
        }

        public void poll_events () {
            _sdl_renderer.clear ();

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

                            case SDL.WindowEventType.FOCUS_GAINED:
                            case SDL.WindowEventType.FOCUS_LOST:
                                on_focus ((_event.window.event == SDL.WindowEventType.FOCUS_GAINED) ? true : false);
                            break; // FOCUS_LOST

                            case SDL.WindowEventType.MAXIMIZED:
                            case SDL.WindowEventType.MINIMIZED:
                                on_maximise ((_event.window.event == SDL.WindowEventType.MAXIMIZED) ? true : false);
                            break; // MAXIMIZED && MINIMIZED

                            case SDL.WindowEventType.ENTER:
                            case SDL.WindowEventType.LEAVE:
                                on_mouse_enter ((_event.window.event == SDL.WindowEventType.ENTER) ? true : false);
                            break; // ENTER && LEAVE

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
            _sdl_renderer.present ();
        }

        public bool should_close () {
            return _should_close;
        }

        public void set_should_close (bool should_close) {
            _should_close = should_close;
        }

        private signal void on_move (int x, int y);
        private signal void on_resize (int width, int height);
        private signal void on_close ();
        private signal void on_focus (bool focused);
        private signal void on_maximise (bool maximised);

        private signal void on_mouse_button (int x, int y, int button, int action, int clicks);
        private signal void on_mouse_cursor (int x, int y);
        private signal void on_mouse_enter (bool entered);
        private signal void on_mouse_scroll (int xscroll, int yscroll);

        private signal void on_key (int state, int repeat, int key);
    }
}
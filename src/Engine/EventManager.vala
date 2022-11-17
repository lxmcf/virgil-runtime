namespace Virgil.Engine {
    internal class EventManager {
        private Window? _window;
        private InputManager? _input;

        private SDL.Event _event;

        public EventManager (Window? window = null, InputManager? input = null) {
            _window = window;
            _input = input;
        }

        public void poll () {
            while (SDL.Event.poll (out _event) == 1) {
                switch (_event.type) {
                    case SDL.EventType.QUIT:
                        _window.set_should_close (true);

                        _on_close ();
                    break; // QUIT

                    case SDL.EventType.MOUSEBUTTONDOWN:
                    case SDL.EventType.MOUSEBUTTONUP:
                        _on_mouse_button (_event.button.x, _event.button.y, _event.button.button, _event.button.state, _event.button.clicks);
                    break; // MOUSEBUTTONDOWN && MOUSEBUTTONUP

                    case SDL.EventType.MOUSEMOTION:
                        _on_mouse_cursor (_event.motion.x, _event.motion.y);
                    break; // MOUSEMOTION

                    case SDL.EventType.MOUSEWHEEL:
                        _on_mouse_scroll (_event.wheel.x, _event.wheel.y);
                    break; // MOUSEWHEEL

                    case SDL.EventType.KEYDOWN:
                    case SDL.EventType.KEYUP:
                        _on_key (_event.key.state, _event.key.repeat, _event.key.keysym.sym);
                    break; // KEYDOWN && KEYUP

                    case SDL.EventType.WINDOWEVENT:
                        switch (_event.window.event) {
                            case SDL.WindowEventType.MOVED:
                                _on_move (_event.window.data1, _event.window.data2);
                            break; // MOVED

                            case SDL.WindowEventType.RESIZED:
                                _on_resize (_event.window.data1, _event.window.data2);
                            break; // RESIZED

                            case SDL.WindowEventType.MAXIMIZED:
                            case SDL.WindowEventType.MINIMIZED:
                                _on_maximise ((_event.window.event == SDL.WindowEventType.MAXIMIZED) ? true : false);
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

        private void _on_move (int x, int y) { }
        private void _on_resize (int width, int height) { }
        private void _on_close () { }
        private void _on_maximise (bool maximised) { }

        private void _on_mouse_button (int x, int y, int button, int action, int clicks) {
            _input.update_mouse_button (button, action);
        }

        private void _on_mouse_cursor (int x, int y) {
            _input.update_mouse_position (x, y);
        }

        private void _on_mouse_scroll (int xscroll, int yscroll) {
            _input.update_mouse_axis (xscroll, yscroll);
        }

        private void _on_key (int state, int repeat, int keycode) {
            if (repeat == 0) {
                _input.update_keyboard_key (keycode, state);
            }
        }
    }
}

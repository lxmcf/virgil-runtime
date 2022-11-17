using Virgil.Input;

namespace Virgil.Engine {
    internal class InputManager {
        //  Singleton
        private static InputManager? _instance;
        public static InputManager instance {
            get {
                if (_instance != null) {
                    return _instance;
                } else {
                    _instance = new InputManager ();
                    return _instance;
                }
            }
        }

        private const int PRESSED = 1;
        private const int RELEASED = 0;

        private const int MAX_KEYS = SDL.Input.Scancode.NUM_SCANCODES;
        private const int MAX_BUTTONS = 5;

        private int[] _keyboard_keys_state;
        private int[] _keyboard_keys_state_previous;

        private Point _mouse_position;

        private int[] _mouse_buttons_state;
        private int[] _mouse_buttons_state_previous;

        private int _mouse_wheel_horizontal_axis;
        private int _mouse_wheel_vertical_axis;

        public InputManager () {
            _keyboard_keys_state = new int[MAX_KEYS];            // Magic number for amount of tracked keys
            _keyboard_keys_state_previous = new int[MAX_KEYS];   // Magic number for amount of tracked keys

            _mouse_buttons_state = new int[MAX_BUTTONS];
            _mouse_buttons_state_previous = new int[MAX_BUTTONS];

            _mouse_wheel_horizontal_axis = 0;
            _mouse_wheel_vertical_axis = 0;

            _instance = this;
        }

        //  KEYBOARD INPUT

        public void update_keyboard_key (KeyCode keycode, int key_state) {
            _keyboard_keys_state_previous[keycode] = _keyboard_keys_state[keycode];

            _keyboard_keys_state[keycode] = key_state;
        }

        public bool is_keyboard_key_pressed (KeyCode keycode) {
            bool current_state = (_keyboard_keys_state_previous[keycode] == RELEASED && _keyboard_keys_state[keycode] == PRESSED);

            if (current_state) {
                _keyboard_keys_state_previous[keycode] = _keyboard_keys_state[keycode];
            }

            return current_state;
        }

        public bool is_keyboard_key_released (KeyCode keycode) {
            bool current_state = (_keyboard_keys_state_previous[keycode] == PRESSED && _keyboard_keys_state[keycode] == RELEASED);

            if (current_state) {
                _keyboard_keys_state_previous[keycode] = _keyboard_keys_state[keycode];
            }

            return current_state;
        }

        public int get_key_state (KeyCode keycode) {
            return _keyboard_keys_state[keycode];
        }

        //  MOUSE INPUT

        public void update_mouse_button (MouseButton button, int button_state) {
            _mouse_buttons_state_previous[button] = _mouse_buttons_state[button];

            _mouse_buttons_state[button] = button_state;
        }

        public void update_mouse_position (int x, int y) {
            _mouse_position = { x, y };
        }

        public void update_mouse_axis (int xscroll, int yscroll) {
            _mouse_wheel_horizontal_axis = xscroll;
            _mouse_wheel_vertical_axis = yscroll;
        }

        public bool is_mouse_button_pressed (MouseButton button) {
            bool current_state = (_mouse_buttons_state_previous[button] == RELEASED && _mouse_buttons_state[button] == PRESSED);

            if (current_state) {
                _mouse_buttons_state_previous[button] = _mouse_buttons_state[button];
            }

            return current_state;
        }

        public bool is_mouse_button_released (MouseButton button) {
            bool current_state = (_mouse_buttons_state_previous[button] == PRESSED && _mouse_buttons_state[button] == RELEASED);

            if (current_state) {
                _mouse_buttons_state_previous[button] = _mouse_buttons_state[button];
            }

            return current_state;
        }

        public bool is_mouse_button_down (MouseButton button) {
            return _mouse_buttons_state[button] == PRESSED;
        }

        public Point get_mouse_position () {
            return _mouse_position;
        }

        public int get_mouse_scroll_horizontal () {
            int value = _mouse_wheel_horizontal_axis;

            _mouse_wheel_horizontal_axis = 0;

            return value;
        }

        public int get_mouse_scroll_vertical () {
            int value = _mouse_wheel_vertical_axis;

            _mouse_wheel_vertical_axis = 0;

            return value;
        }
    }
}

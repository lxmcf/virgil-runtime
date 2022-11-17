using Virgil.Engine;

namespace Virgil.Input {
    public const int KEY_DOWN = 1;
    public const int KEY_UP = 0;

    public static bool check_key (KeyCode keycode) {
        InputManager input_manager = InputManager.instance;

        return input_manager.get_key_state (keycode) == KEY_DOWN;
    }

    public static int check_key_state (KeyCode keycode) {
        InputManager input_manager = InputManager.instance;

        return input_manager.get_key_state (keycode);
    }

    public static bool check_key_released (KeyCode keycode) {
        InputManager input_manager = InputManager.instance;

        return input_manager.is_keyboard_key_released (keycode);
    }

    public static bool check_key_pressed (KeyCode keycode) {
        InputManager input_manager = InputManager.instance;

        return input_manager.is_keyboard_key_pressed (keycode);
    }
}

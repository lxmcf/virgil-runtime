using Virgil.Engine;

// TODO: Remove need for so many input manager references via engine state

namespace Virgil.Input {
    public static bool check_key (KeyCode keycode) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_keyboard_key_down (keycode);
    }

    public static bool check_key_released (KeyCode keycode) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_keyboard_key_released (keycode);
    }

    public static bool check_key_pressed (KeyCode keycode) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_keyboard_key_pressed (keycode);
    }
}
using Virgil.Engine;

// TODO: Remove need for so many input manager references via engine state

namespace Virgil.Input {
    public static bool check_mouse_button (MouseButton button) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_mouse_button_down (button);
    }

    public static bool check_mouse_button_released (MouseButton button) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_mouse_button_released (button);
    }

    public static bool check_mouse_button_pressed (MouseButton button) {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.is_mouse_button_pressed (button);
    }

    public static Point get_mouse_position () {
        InputManager input_manager = EngineState.instance.input_manager;

        return input_manager.get_mouse_position ();
    }
}
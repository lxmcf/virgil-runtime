using Virgil.Engine;

namespace Virgil.Input {
    public const int SCROLL_LEFT = -1;
    public const int SCROLL_RIGHT = 1;

    public const int SCROLL_UP = 1;
    public const int SCROLL_DOWN = -1;

    public static bool check_mouse_button (MouseButton button) {
        InputManager input_manager = InputManager.instance;

        return input_manager.is_mouse_button_down (button);
    }

    public static bool check_mouse_button_released (MouseButton button) {
        InputManager input_manager = InputManager.instance;

        return input_manager.is_mouse_button_released (button);
    }

    public static bool check_mouse_button_pressed (MouseButton button) {
        InputManager input_manager = InputManager.instance;

        return input_manager.is_mouse_button_pressed (button);
    }

    public static Point get_mouse_position () {
        InputManager input_manager = InputManager.instance;

        return input_manager.get_mouse_position ();
    }

    public static int get_mouse_scroll_horizontal () {
        InputManager input_manager = InputManager.instance;

        return input_manager.get_mouse_scroll_horizontal ();
    }

    public static int get_mouse_scroll_vertical () {
        InputManager input_manager = InputManager.instance;

        return input_manager.get_mouse_scroll_vertical ();
    }
}
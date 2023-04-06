namespace Virgil.Input {
    public const int SCROLL_LEFT = -1;
    public const int SCROLL_RIGHT = 1;

    public const int SCROLL_UP = 1;
    public const int SCROLL_DOWN = -1;

    public inline static bool check_mouse_button (MouseButton button) {
        return Raylib.is_mouse_button_down ((Raylib.MouseButton)button);
    }

    public inline static bool check_mouse_button_released (MouseButton button) {
        return Raylib.is_mouse_button_released ((Raylib.MouseButton)button);
    }

    public inline static bool check_mouse_button_pressed (MouseButton button) {
        return Raylib.is_mouse_button_pressed ((Raylib.MouseButton)button);
    }

    public inline static Vector2 get_mouse_position () {
        Raylib.Vector2 position = Raylib.get_mouse_position ();

        return { position.x, position.y };
    }

    public inline float get_mouse_scroll () {
        return Raylib.get_mouse_wheel_move ();
    }
}

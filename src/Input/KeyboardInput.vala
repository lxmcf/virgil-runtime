namespace Virgil.Input {
    public const int KEY_DOWN = 1;
    public const int KEY_UP = 0;

    public static bool check_key (KeyCode keycode) {
        return Raylib.is_key_down ((Raylib.KeyboardKey)keycode);
    }

    public static bool check_key_released (KeyCode keycode) {
        return Raylib.is_key_released ((Raylib.KeyboardKey)keycode);
    }

    public static bool check_key_pressed (KeyCode keycode) {
        return Raylib.is_key_pressed ((Raylib.KeyboardKey)keycode);
    }
}

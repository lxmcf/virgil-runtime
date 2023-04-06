namespace Virgil.Input {
    public const int KEY_DOWN = 1;
    public const int KEY_UP = 0;

    public inline static bool check_key (KeyCode keycode) {
        return Raylib.is_key_down ((Raylib.KeyboardKey)keycode);
    }

    public inline static int check_key_raw (KeyCode keycode) {
        return (int)Raylib.is_key_down ((Raylib.KeyboardKey)keycode);
    }

    public inline static bool check_key_released (KeyCode keycode) {
        return Raylib.is_key_released ((Raylib.KeyboardKey)keycode);
    }

    public inline static bool check_key_pressed (KeyCode keycode) {
        return Raylib.is_key_pressed ((Raylib.KeyboardKey)keycode);
    }
}

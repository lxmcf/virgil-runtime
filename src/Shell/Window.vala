namespace Virgil.Shell {
    public inline static void set_window_title (string title) {
        Raylib.set_window_title (title);
    }

    public inline static void set_window_size (int width, int height) {
        Raylib.set_window_size (width, height);
    }

    public inline static void set_window_position (int x, int y) {
        Raylib.set_window_position (x, y);
    }

    public inline static void set_window_flag (WindowFlag flag, bool enabled = true) {
        if (enabled) {
            Raylib.set_window_state ((int)flag);
        } else {
            Raylib.clear_window_state ((int)flag);
        }
    }

    public inline static Vector2 get_window_size () {
        return { Raylib.get_screen_width (), Raylib.get_screen_height () };
    }

    public inline static Vector2 get_window_position () {
        Raylib.Vector2 position = Raylib.get_window_position ();

        return { position.x, position.y };
    }

    public inline static bool get_window_flag (WindowFlag flag) {
        return Raylib.is_window_state ((int)flag);
    }

    public inline static Rectangle get_window_rectangle () {
        Raylib.Vector2 position = Raylib.get_window_position ();

        return { position.x, position.y, Raylib.get_screen_width (), Raylib.get_screen_height () };
    }

    public inline static Vector2 get_window_scale () {
        Raylib.Vector2 scale = Raylib.get_window_scale_dpi ();

        return { scale.x, scale.y };
    }

    [Version (experimental = true)]
    public inline static void* get_native_window_handle () {
        return Raylib.get_window_handle ();
    }
}

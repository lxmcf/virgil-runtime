namespace Virgil.Shell {
    public static void set_window_title (string title) {
        Raylib.set_window_title (title);
    }

    public static void set_window_size (int width, int height) {
        Raylib.set_window_size (width, height);
    }

    public static void set_window_position (int x, int y) {
        Raylib.set_window_position (x, y);
    }

    public static void set_window_flag (WindowFlag flag, bool enabled = true) {
        if (enabled) {
            Raylib.set_window_state ((int)flag);
        } else {
            Raylib.clear_window_state ((int)flag);
        }
    }

    public static float set_window_opacity (float opacity) {
        Raylib.set_window_opacity (opacity);

        return opacity;
    }

    public static Vector2 get_window_size () {
        return { Raylib.get_screen_width (), Raylib.get_screen_height () };
    }

    public static Vector2 get_window_position () {
        Raylib.Vector2 position = Raylib.get_window_position ();

        return { position.x, position.y };
    }

    public static bool get_window_flag (WindowFlag flag) {
        return Raylib.is_window_state ((int)flag);
    }

    public static Rectangle get_window_rectangle () {
        Raylib.Vector2 position = Raylib.get_window_position ();

        return { position.x, position.y, Raylib.get_screen_width (), Raylib.get_screen_height () };
    }

    public static Vector2 get_window_scale () {
        Raylib.Vector2 scale = Raylib.get_window_scale_dpi ();

        return { scale.x, scale.y };
    }

    public static void minimise_window () {
        Raylib.minimize_window ();
    }

    public static void maximise_window () {
        Raylib.maximise_window ();
    }

    public static bool toggle_window_fullscreen () {
        Raylib.toggle_fullscreen ();

        return Raylib.is_window_fullscreen ();
    }

    //  NOTE: This will likely never not be experimental for... Obvious reasons
    //  NOTE: Maybe make internal so can only be used for engine modules? Idk man
    [Version (experimental = true)]
    public static void* get_native_window_handle () {
        return Raylib.get_window_handle ();
    }
}

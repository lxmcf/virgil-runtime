namespace Virgil.Shell {
    public inline static void show_cursor () {
        Raylib.show_cursor ();
    }

    public inline static void hide_cursor () {
        Raylib.hide_cursor ();
    }

    public inline static bool is_cursor_hidden () {
        return Raylib.is_cursor_hidden ();
    }

    public inline static bool is_cursor_on_screen () {
        return Raylib.is_cursor_hidden ();
    }
}

using Virgil.Input;

namespace Virgil.GUI {
    [Version (experimental = true)]
    public static bool button (Rectangle bounds) {
        //  TODO: Impliment UI disabling/enabling
        bool result = false;

        Vector2 mouse = get_mouse_position ();

        if (point_in_rectangle (mouse, bounds)) {
            if (check_mouse_button_pressed (MouseButton.LEFT)) result = true;
        }

        draw_rectangle (bounds, Colour.RED);

        return result;
    }

    [Version (experimental = true)]
    public static void toggle (Rectangle bounds, ref bool active) {
        Vector2 mouse = get_mouse_position ();

        if (point_in_rectangle (mouse, bounds)) {
            if (check_mouse_button_pressed (MouseButton.LEFT)) {
                active = !active;
            }
        }

        if (active) {
            draw_rectangle (bounds, Colour.RED);
        } else {
            draw_rectangle (bounds, Colour.BLUE);
        }
    }
}

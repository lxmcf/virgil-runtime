namespace Virgil.Input {
    public inline static bool is_gamepad_connected (int id) {
        return Raylib.is_gamepad_available (id);
    }

    public inline static string get_gamepad_name (int id) {
        return Raylib.get_gamepad_name (id);
    }

    public inline static bool check_gamepad_button_pressed (int id, GamepadButton button) {
        return Raylib.is_gamepad_button_pressed (id, (Raylib.GamepadButton)button);
    }

    public inline static bool check_gamepad_button (int id, GamepadButton button) {
        return Raylib.is_gamepad_button_down (id, (Raylib.GamepadButton)button);
    }

    public inline static bool check_gamepad_button_released (int id, GamepadButton button) {
        return Raylib.is_gamepad_button_released (id, (Raylib.GamepadButton)button);
    }

    public inline static float get_gamepad_axis (int id, GamepadAxis axis) {
        return Raylib.get_gamepad_axis_movement (id, (Raylib.GamepadAxis)axis);
    }

    public inline static Vector2 get_gamepad_stick_axis (int id, GamepadStick stick) {
        Vector2 result = Vector2.ZERO;

        if (stick == GamepadStick.LEFT) {
            result = {
                get_gamepad_axis (id, GamepadAxis.STICK_LEFT_X),
                get_gamepad_axis (id, GamepadAxis.STICK_LEFT_Y)
            };
        } else if (stick == GamepadStick.RIGHT) {
            result = {
                get_gamepad_axis (id, GamepadAxis.STICK_RIGHT_X),
                get_gamepad_axis (id, GamepadAxis.STICK_LEFT_X)
            };
        }

        return result;
    }
}

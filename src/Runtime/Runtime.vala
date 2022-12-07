namespace Virgil.Runtime {
    //----------------------------------------------------------------------------------
    // Global variables
    //----------------------------------------------------------------------------------
    private static DrawState _draw_state;

    //----------------------------------------------------------------------------------
    // Global funcitons
    //----------------------------------------------------------------------------------
    internal static void set_draw_state (DrawState state) {
        _draw_state = state;
    }

    internal static DrawState get_draw_state () {
        return _draw_state;
    }
}

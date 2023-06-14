namespace Virgil.Runtime {
    //----------------------------------------------------------------------------------
    // INTERNAL API
    //----------------------------------------------------------------------------------
    private static OptionContext _option_context;

    internal static void init_option_context () {
        _option_context = new OptionContext ("- Virgil Game Engine");

        _option_context.set_help_enabled (true);
    }

    internal unowned OptionContext get_option_context () {
        return _option_context;
    }


    //----------------------------------------------------------------------------------
    // PUBLIC API
    //----------------------------------------------------------------------------------

}

namespace Virgil.Shell {
    [Flags]
    public enum WindowFlag {
        VSYNC = Raylib.ConfigFlags.VSYNC_HINT,
        FULLSCREEN = Raylib.ConfigFlags.FULLSCREEN_MODE,
        RESIZABLE = Raylib.ConfigFlags.WINDOW_RESIZABLE,
        UNDECORATED = Raylib.ConfigFlags.WINDOW_UNDECORATED,
        HIDDEN = Raylib.ConfigFlags.WINDOW_HIDDEN,
        MINIMISED = Raylib.ConfigFlags.WINDOW_MINIMIZED,
        MAXIMISED = Raylib.ConfigFlags.WINDOW_MAXIMIZED,
        UNFOCUSED = Raylib.ConfigFlags.WINDOW_UNFOCUSED,
        TOP = Raylib.ConfigFlags.WINDOW_TOPMOST,
        CONSTANT = Raylib.ConfigFlags.WINDOW_ALWAYS_RUN,
        TRANSPARENT = Raylib.ConfigFlags.WINDOW_TRANSPARENT,
        HIGH_DPI = Raylib.ConfigFlags.WINDOW_HIGHDPI,
        MOUSE_PASSTHROUGH = Raylib.ConfigFlags.WINDOW_MOUSE_PASSTHROUGH,
        MSAA_4X = Raylib.ConfigFlags.MSAA_4X_HINT,
        INTERLACED = Raylib.ConfigFlags.INTERLACED_HINT
    }
}

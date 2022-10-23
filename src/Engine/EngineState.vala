namespace Virgil.Engine {
    internal class EngineState {
        private static EngineState? _instance;

        public static EngineState instance {
            get {
                if (_instance != null) {
                    return _instance;
                } else {
                    _instance = new EngineState ();
                    return _instance;
                }
            }
        }

        public unowned SDL.Video.Window? sdl_window;
        public unowned SDL.Video.Renderer? sdl_renderer;

        public unowned InputManager? input_manager;

        private EngineState () { }
    }
}
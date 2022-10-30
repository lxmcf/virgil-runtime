using Virgil.Engine;

namespace Virgil {
    public class Game : Object {
        //  Core methods
        public virtual void init () { }
        public virtual void update (float delta_time) { }
        public virtual void draw () { }

        // Content
        public virtual void load_content () { }
        public virtual void unload_content () { }

        // TODO: Work on something cleaner (Potentially Application or GameState class)
        protected static void quit () {
            Window window = Window.instance;

            window.set_should_close (true);
        }
    }
}
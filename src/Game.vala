namespace Virgil {
    public class Game : Object {
        internal static bool should_close;

        public GameObject root { get; private set; }

        //----------------------------------------------------------------------------------
        // Internal API
        //----------------------------------------------------------------------------------
        internal void do_start () {
            root = new GameObject ();

            start ();
        }

        internal void do_update (float delta_time) {
            root.update_object ();

            update (delta_time);
        }

        internal void do_draw () {
            root.draw_object ();

            draw ();
        }

        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public virtual void start () { }
        public virtual void update (float delta_time) { }
        public virtual void draw () { }

        //----------------------------------------------------------------------------------
        // Content loading
        //----------------------------------------------------------------------------------
        public virtual void load_content () { }
        public virtual void unload_content () { }

        //----------------------------------------------------------------------------------
        // Public functions
        //----------------------------------------------------------------------------------
        public static void quit () {
            should_close = true;
        }

        public static void set_window_size (int width, int height) {
            Raylib.set_window_size (width, height);
        }

        public static void set_window_rectangle (Rectangle rectangle) {
            Raylib.set_window_position (rectangle.x, rectangle.y);

            Raylib.set_window_size (rectangle.width, rectangle.height);
        }

        public static Rectangle get_window_rectangle () {
            Raylib.Vector2 position = Raylib.get_window_position ();

            return { (int)position.x, (int)position.y, Raylib.get_screen_width (), Raylib.get_screen_height () };
        }
    }
}

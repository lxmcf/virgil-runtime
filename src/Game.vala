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
            begin_draw ();

            root.draw_object ();

            draw ();

            end_draw ();
        }

        internal void do_draw_gui () {
            root.draw_object_gui ();

            draw_gui ();
        }

        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public virtual void start () { }
        public virtual void update (float delta_time) { }

        public virtual void begin_draw () { }
        public virtual void draw () { }
        public virtual void end_draw () { }

        public virtual void draw_gui () { }

        //----------------------------------------------------------------------------------
        // Public functions
        //----------------------------------------------------------------------------------
        public void instantiate (GameObject object) {
            //  NOTE: Mimics instantiation inside of GameObject
            root.add_child (object);
        }

        public static void quit () {
            should_close = true;
        }
    }
}

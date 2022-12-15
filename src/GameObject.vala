using Virgil.Runtime;

namespace Virgil {
    public class GameObject {
        private List<Component> _components;

        public Transform transform;

        public string name;

        public GameObject () {
            _components = new List<Component> ();

            transform = new Transform ();

            Type type = Type.from_instance (this);
            name = type.name ();

            start ();
        }

        ~GameObject () {
            warning ("GameObject destroyed!");
        }

        //  NOTE: API NOT FINAL
        //----------------------------------------------------------------------------------
        // User defined functions
        //----------------------------------------------------------------------------------
        protected virtual void start () { }

        protected virtual void update (float delta_time) { }

        protected virtual void draw () { }

        //----------------------------------------------------------------------------------
        // Public update functions
        //----------------------------------------------------------------------------------
        public void update_object () {
            foreach (Component component in _components) {
                component.update ();
            }

            update (Raylib.get_frame_time ());
        }

        public void draw_object () {
            foreach (Component component in _components) {
                component.begin_draw ();
            }

            draw ();

            foreach (Component component in _components) {
                component.draw ();
            }

            foreach (Component component in _components) {
                component.end_draw ();
            }
        }

        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public void add_component (owned Component component) {
            Type desired_component = Type.from_instance (component);

            foreach (Component item in _components) {
                Type current_component = Type.from_instance (item);

                if (current_component == desired_component) return;
            }

            component.object = this;
            component.start ();

            _components.append (component);
        }

        //  NOTE: Really want this to be the final API, unsure how to work it in vala
        //  public void add_component_exp<T> () { }

        public T get_component<T> () {
            Type desired_component = typeof (T);

            foreach (Component item in _components) {
                Type current_component = Type.from_instance (item);

                if (current_component == desired_component) {
                    return item;
                }
            }

            return null;
        }
    }
}

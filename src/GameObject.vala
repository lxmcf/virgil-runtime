using Virgil.Runtime;

namespace Virgil {
    public class GameObject {
        private bool is_parented;
        private List<Component> _components;
        private List<GameObject> _children;

        public unowned GameObject parent;
        public Transform transform;

        public GameObject () {
            parent = null;

            _components = new List<Component> ();
            _children = new List<GameObject> ();
            is_parented = false;

            transform = {
                { 0.0f, 0.0f },

                1.0f,
                0.0f
            };

            start ();
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
                ((Camera2D)component).update ();
            }

            update (Raylib.get_frame_time ());
        }

        public void draw_object () {
            foreach (Component component in _components) {
                component.begin_draw ();
            }


            draw ();

            foreach (Component component in _components) {
                component.end_draw ();
            }
        }

        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public void add_child (owned GameObject child) {
            _children.append (child);
        }

        public void remove_child (GameObject child) {
            _children.remove (child);
        }

        public unowned List<GameObject> get_children () {
            return _children;
        }

        public void set_parent (GameObject object) {
            Transform parent_transform = parent.transform;

            transform.position = Vector2.add (transform.position, parent_transform.position);

            transform.scale += parent.transform.scale;
            transform.rotation += parent_transform.rotation;

            parent = object;

            is_parented = true;
        }

        public void remove_parent (bool relative = true) {
            if (!is_parented) return;

            is_parented = false;

            if (relative) {
                Transform parent_transform = parent.transform;

                transform.position = Vector2.add (transform.position, parent_transform.position);

                transform.rotation += parent_transform.rotation;
                transform.scale += parent_transform.scale;
            }
        }

        public void add_component (owned Component component) {
            Type desired_component = Type.from_instance (component);

            foreach (Component item in _components) {
                Type current_component = Type.from_instance (item);

                if (current_component == desired_component) return;
            }

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

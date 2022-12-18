using Virgil.Runtime;

namespace Virgil {
    public class GameObject {
        private List<Component> _components;
        private List<GameObject> _children;

        private GameObject? _parent;

        public Transform transform;

        public string name;

        public GameObject () {
            _components = new List<Component> ();
            _children = new List<GameObject> ();

            transform = new Transform ();

            _parent = null;

            Type type = Type.from_instance (this);
            name = type.name ();

            start ();
        }

        ~GameObject () {
            warning ("GameObject [%s] destroyed!", name);
        }

        //  NOTE: API NOT FINAL
        //----------------------------------------------------------------------------------
        // User defined functions
        //----------------------------------------------------------------------------------
        public virtual void start () { }

        public virtual void update (float delta_time) { }

        public virtual void draw () { }

        //  NOTE: Not final
        public virtual void collide_2D (Collider2D collider) { }                                                        // vala-lint=naming-convention

        //----------------------------------------------------------------------------------
        // Public update functions
        //----------------------------------------------------------------------------------
        public void update_object () {
            foreach (Component component in _components) {
                component.update ();
            }

            update (Raylib.get_frame_time ());

            foreach (GameObject child in _children) {
                child.update_object ();
            }
        }

        public void draw_object () {
            foreach (Component component in _components) {
                component.begin_draw ();
            }

            draw ();

            foreach (GameObject child in _children) {
                child.draw_object ();
            }

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

                if (current_component == desired_component) {
                    warning ("Component of type %s already added to GameObject!", current_component.name ());

                    return;
                }
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

        public GameObject add_child (GameObject object) {
            _children.append (object);

            object.set_parent (this);

            return object;
        }

        public void set_parent (GameObject? object) {
            _parent = object;
        }
    }
}

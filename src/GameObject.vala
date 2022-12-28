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

                draw_line (get_relative_position (), child.get_relative_position ());
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

        public GameObject get_root_parent () {
            GameObject? root_parent = _parent;

            if (_parent != null) {
                root_parent = _parent.get_root_parent ();
            }

            return (root_parent == null) ? this : root_parent;
        }

        public Vector2 get_relative_position () {
            Vector2 position = transform.position;

            if (_parent != null) {
                position = Vector2.rotate (position, get_relative_rotation ());
                position = Vector2.add (position, _parent.get_relative_position ());
            }

            return position;
        }

        public float get_relative_rotation () {
            float rotation = transform.rotation;

            if (_parent != null) {
                rotation += _parent.get_relative_rotation ();
            }

            return rotation;
        }
    }
}

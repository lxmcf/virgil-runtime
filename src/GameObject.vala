using Virgil.Runtime;

//  TODO: Clean up the amount of loops
namespace Virgil {
    public class GameObject {
        public delegate int SortFunction (GameObject object1, GameObject object2);

        private List<Component> _components;
        private List<GameObject> _children;

        private GameObject? _parent;

        public GameObject? parent {
            get { return _parent; }
        }

        public Transform transform;
        public Transform world_transform { get; private set; }

        //  NOTE: Need more testing to see if return world transform is best option
        public Vector2 position {
            get { return world_transform.position; }
            set { transform.position = value; }
        }

        public Vector2 scale {
            get { return world_transform.scale; }
            set { transform.scale = value; }
        }

        public float rotation {
            get { return world_transform.rotation; }
            set { transform.rotation = value; }
        }

        public string name { get; private set; }
        public bool enabled;

        public GameObject () {
            _components = new List<Component> ();
            _children = new List<GameObject> ();

            transform = new Transform ();
            world_transform = new Transform ();

            _parent = null;

            Type type = Type.from_instance (this);
            name = type.name ();

            enabled = true;

            start ();
        }

        ~GameObject () {
            print ("Object type %s deleting!\n", name);

            while (_components.length () > 0) {
                Component component = _components.nth_data (0);
                string component_name = component.name;

                _components.remove (component);

                print ("\tComponent type %s deleted!\n", component_name);
            }

            print ("Object type %s deleted!\n\n", name);
        }

        //----------------------------------------------------------------------------------
        // Internal API
        //----------------------------------------------------------------------------------
        internal void update_object () {
            if (!enabled) return;

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.update ();
            }

            update (Raylib.get_frame_time ());

            if (parent != null) {
                world_transform.position = get_world_position ();
                world_transform.rotation = get_world_rotation ();
                world_transform.scale = get_world_scale ();
            } else {
                world_transform.position = transform.position;
                world_transform.rotation = transform.rotation;
                world_transform.scale = transform.scale;
            }

            foreach (GameObject child in _children) {
                child.update_object ();
            }
        }

        internal void draw_object () {
            if (!enabled) return;

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.begin_draw ();
            }

            draw ();

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.draw ();
            }

            foreach (GameObject child in _children) {
                child.draw_object ();
            }

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.end_draw ();
            }
        }

        //  TODO: Move to single projection method
        internal Vector2 get_world_position () {
            if (!enabled) return Vector2.ZERO;

            Vector2 position = transform.position;

            if (parent != null) {
                position = Vector2.rotate (position, get_world_rotation () - transform.rotation);
                position = Vector2.add (position, parent.get_world_position ());
            }

            return position;
        }

        //  TODO: Move to single projection method
        internal float get_world_rotation () {
            if (!enabled) return 0.0f;

            float rotation = transform.rotation;

            if (parent != null) {
                rotation += parent.get_world_rotation ();
            }

            return rotation % 360;
        }

        //  TODO: Move to single projection method
        internal Vector2 get_world_scale () {
            if (!enabled) return Vector2.ZERO;

            Vector2 scale = transform.scale;

            if (parent != null) {
                scale = Vector2.multiply (scale, parent.get_world_scale ());
            }

            return scale;
        }

        //  NOTE: API NOT FINAL
        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public virtual void start () { }

        public virtual void update (float delta_time) { }

        public virtual void draw () { }

        //  NOTE: Not final
        public virtual void collide_2D (Collider2D collider) { }

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

        public T add_component_return <T> (owned Component component) {
            Type desired_component = Type.from_instance (component);

            foreach (Component item in _components) {
                Type current_component = Type.from_instance (item);

                if (current_component == desired_component) {
                    warning ("Component of type %s already added to GameObject!", current_component.name ());

                    return item;
                }
            }

            component.object = this;
            component.start ();

            _components.append (component);

            return component;
        }

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

        public GameObject get_root_parent () {
            GameObject? root = parent;

            while (root != null) {
                if (root.parent != null) {
                    root = root.parent;
                } else break;
            }

            return root;
        }

        public GameObject add_child (GameObject object) {
            _children.append (object);

            object.set_parent (this);

            return object;
        }

        public unowned List<GameObject> get_children () {
            return _children;
        }

        public void remove_child (GameObject object) {
            GameObject root = get_root_parent ();

            _children.remove (object);

            root.add_child (object);
        }

        public void sort_children (SortFunction sort_function) {
            _children.sort ((GLib.CompareFunc<GameObject>)sort_function);
        }

        public void set_parent (GameObject? object) {
            _parent = object;
        }

        public GameObject instantiate (GameObject object) {
            GameObject root = get_root_parent ();

            return root.add_child (object);
        }

        public void destroy (GameObject object) {
            if (object.parent == null) return;

            object.parent.remove_child (object);
        }

        public void destroy_self () {
            destroy (this);
        }
    }
}

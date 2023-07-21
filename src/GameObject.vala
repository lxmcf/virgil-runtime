using Virgil.Runtime;

//  TODO: Clean up the amount of loops
namespace Virgil {
    public class GameObject {
        public delegate int SortFunction (GameObject object1, GameObject object2);

        private List<Component> _components;
        private List<GameObject> _children;

        private GameObject? _parent;

        private Transform _local_transform;
        private Transform _world_transform;

        private Transform _temp_transform;

        public GameObject? parent {
            get { return _parent; }
        }

        public Vector2 position {
            get { return _world_transform.position; }
            set { _local_transform.position = value; }
        }

        public Vector2 scale {
            get { return _world_transform.scale; }
            set { _local_transform.scale = value; }
        }

        public float rotation {
            get { return _world_transform.rotation; }
            set { _local_transform.rotation = value; }
        }

        public Transform transform {
            get { return _local_transform; }
            set { _local_transform = value; }
        }

        public string name { get; private set; }
        public bool enabled;

        public GameObject () {
            _components = new List<Component> ();
            _children = new List<GameObject> ();

            _local_transform = new Transform ();
            _world_transform = new Transform ();

            _temp_transform = new Transform ();

            _parent = null;

            Type type = Type.from_instance (this);
            name = type.name ();

            enabled = true;

            start ();
        }

        ~GameObject () {
            //  print ("Object type %s deleting!\n", name);

            while (_components.length () > 0) {
                Component component = _components.nth_data (0);
                string component_name = component.name;

                _components.remove (component);

                //  print ("\tComponent type %s deleted!\n", component_name);
            }

            //  print ("Object type %s deleted!\n\n", name);
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

            _world_transform = _local_to_world_transform ();

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

        //  FIXME: This is conciderably slower than calling each relative function individually...
        private Transform _local_to_world_transform () {
            if (!enabled) return new Transform ();

            if (parent == null) {
                return _local_transform;
            }

            _temp_transform.position = _local_transform.position;
            _temp_transform.scale = _local_transform.scale;
            _temp_transform.rotation = _local_transform.rotation;

            _temp_transform.rotation += parent._world_transform.rotation;
            _temp_transform.rotation = _temp_transform.rotation % 360;

            _temp_transform.position = Vector2.rotate (_temp_transform.position, parent._world_transform.rotation);
            _temp_transform.position = Vector2.add (_temp_transform.position, parent._world_transform.position);
            _temp_transform.scale = Vector2.multiply (_temp_transform.scale, parent._world_transform.scale);

            return _temp_transform;
        }

        //  NOTE: API NOT FINAL
        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public virtual void start () { }

        public virtual void update (float delta_time) { }

        public virtual void draw () { }

        //  NOTE: Not final
        public virtual void on_collide (Collider2D collider) { }

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

        public void add_child (GameObject object) {
            _children.append (object);

            object.set_parent (this);
        }

        public T add_child_return <T> (GameObject object) {
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

            warning ("start");
            root.add_child (object);
            warning ("end");
        }

        public void sort_children (SortFunction sort_function) {
            _children.sort ((GLib.CompareFunc<GameObject>)sort_function);
        }

        public void set_parent (GameObject? object) {
            _parent = object;
        }

        public GameObject instantiate (owned GameObject object) {
            GameObject root = get_root_parent ();

            return root.add_child_return<GameObject> (object);
        }

        public void destroy (GameObject object) {
            if (object.parent == null) return;

            object.parent._children.remove (object);
        }

        public void destroy_self () {
            destroy (this);
        }
    }
}

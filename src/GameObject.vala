using Virgil.Runtime;

namespace Virgil {
    public class GameObject {
        private List<Component> _components;
        private List<GameObject> _children;

        private GameObject? _parent;

        public Transform transform;
        public Transform relative_transform { get; private set; }

        public string name { get; private set; }
        public bool enabled;

        public GameObject () {
            _components = new List<Component> ();
            _children = new List<GameObject> ();

            transform = new Transform ();
            relative_transform = new Transform ();

            _parent = null;

            Type type = Type.from_instance (this);
            name = type.name ();

            start ();
        }

        //----------------------------------------------------------------------------------
        // Internal API
        //----------------------------------------------------------------------------------
        internal void update_object () {
            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.update ();
            }

            update (Raylib.get_frame_time ());

            if (_parent != null) {
                relative_transform.position = get_relative_position ();
                relative_transform.rotation = get_relative_rotation ();
                relative_transform.scale = get_relative_scale ();
            } else {
                relative_transform.position = transform.position;
                relative_transform.rotation = transform.rotation;
                relative_transform.scale = transform.scale;
            }

            foreach (GameObject child in _children) {
                child.update_object ();
            }
        }

        internal void draw_object () {
            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.begin_draw ();
            }

            draw ();

            foreach (GameObject child in _children) {
                child.draw_object ();
            }

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.draw ();
            }

            foreach (Component component in _components) {
                if (!component.enabled) continue;

                component.end_draw ();
            }
        }

        internal Vector2 get_relative_position () {
            Vector2 position = transform.position;

            if (_parent != null) {
                position = Vector2.rotate (position, get_relative_rotation () - transform.rotation);
                position = Vector2.add (position, _parent.get_relative_position ());
            }

            return position;
        }

        internal float get_relative_rotation () {
            float rotation = transform.rotation;

            if (_parent != null) {
                rotation += _parent.get_relative_rotation ();
            }

            return rotation % 360;
        }

        internal Vector2 get_relative_scale () {
            Vector2 scale = transform.scale;

            if (_parent != null) {
                scale = Vector2.multiply (scale, _parent.get_relative_scale ());
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
        public virtual void collide_2D (Collider2D collider) { }                                                        // vala-lint=naming-convention

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

        //  NOTE: Really want this to be the final API, unsure how to work it in vala without inheriting GLib.Object
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
    }
}

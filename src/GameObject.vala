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
        protected void start () { }

        protected void update (float delta_time) { }

        protected void draw () { }

        //----------------------------------------------------------------------------------
        // Public update functions
        //----------------------------------------------------------------------------------
        public void run_update () {
            foreach (Component component in _components) {
                component.update ();
            }

            update (Raylib.get_frame_time ());

            foreach (GameObject child in _children) {
                child.run_update ();
            }
        }

        public void run_draw () {
            draw ();

            foreach (GameObject child in _children) {
                child.run_draw ();
            }
        }

        //----------------------------------------------------------------------------------
        // Public API
        //----------------------------------------------------------------------------------
        public void add_child (owned GameObject child) {
            _children.append (child);
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

        public unowned List<GameObject> get_children () {
            return _children;
        }
    }
}

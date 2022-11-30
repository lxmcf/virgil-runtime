using Virgil.Scenes;

namespace Virgil {
    public class GameObject {
        private unowned GameObject? _parent;
        private unowned Scene? _parent_scene;

        private List<Script> _scripts;
        private List<GameObject> _children;

        public Transform transform;

        public GameObject () {
            _parent = null;
            _parent_scene = null;

            _scripts = new List<Script> ();
            _children = new List<GameObject> ();

            transform = {
                { 0.0f, 0.0f },

                1.0f,
                0.0f
            };

            create ();
        }

        public void create () { }

        public void update (float delta_time) { }

        public void draw () { }

        public void cleanup () { }

        protected void add_child (owned GameObject child) {
            _children.append (child);
        }

        protected void set_parent (GameObject? object) {
            if (object == null) {
                Transform parent_transform = _parent.transform;

                transform.position = Vector2.add (transform.position, parent_transform.position);

                transform.scale += _parent.transform.scale;
                transform.rotation += parent_transform.rotation;
            }

            _parent = object;
        }

        internal void process_update (float delta_time) {
            update (delta_time);

            foreach (GameObject object in _children) {
                object.process_update (delta_time);
            }
        }

        internal void process_draw () {
            draw ();

            foreach (GameObject object in _children) {
                object.draw ();
            }
        }
    }
}

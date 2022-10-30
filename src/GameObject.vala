using Uuid;

namespace Virgil {
    public class GameObject {
        private GameObject? _parent;

        private List<Script> _scripts;
        private List<GameObject> _children;

        public Vector2 position;

        public GameObject () {
            _parent = null;

            _scripts = new List<Script>();
            _children = new List<GameObject> ();

            position = new Vector2 (0.0f, 0.0f);

            create ();
        }

        ~GameObject () {
            cleanup ();
        }

        internal void create () {

        }

        internal void update () {

        }

        internal void cleanup () {

        }
    }
}
using Uuid;

namespace Virgil {
    public class GameObject {
        private GameObject? _parent;

        private List<Script> _scripts;

        private string _uuid;

        public string uuid {
            get { return _uuid; }
        }

        public GameObject () {
            _uuid = Uuid.string_random ();

            _parent = null;
            _scripts = new List<Script>();

            create ();
        }

        ~GameObject () {
            cleanup ();
        }

        internal void create () {
            update (); // HACK: Disable warning
        }

        internal void update () {

        }

        internal void cleanup () {

        }
    }
}
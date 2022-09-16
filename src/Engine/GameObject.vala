using Uuid;

namespace Virgil.Engine {
    public class GameObject {
        private GameObject? _parent;

        public string id;

        public GameObject () {
            id = Uuid.string_random ();

            _parent = null;
        }
    }
}
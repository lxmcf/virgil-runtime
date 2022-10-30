namespace Virgil.Scenes {
    public class Scene {
        private List<GameObject> _objects;

        public Scene () {
            _objects = new List<GameObject> ();
        }

        protected void instantiate (GameObject object, Vector2 position = new Vector2 (0.0f, 0.0f)) {
            _objects.append (object);

            object.position = position;
        }

        protected void update () {
            foreach (GameObject object in _objects) {
                object.update ();
            }
        }
    }
}
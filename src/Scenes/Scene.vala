using Virgil.Engine;

namespace Virgil.Scenes {
    public class Scene {
        private List<GameObject> _objects;

        public int id { get; private set; }

        public Scene () {
            SceneManager manager = SceneManager.instance;

            _objects = new List<GameObject> ();

            id = manager.add_scene (this);
        }

        protected void instantiate (GameObject object, Vector2 position = Vector2 (0.0f, 0.0f)) {
            _objects.append (object);

            object.transform.position = position;
        }

        public virtual void start () { }
        public virtual void end () { }

        public virtual void update (float delta_time) { }

        public virtual void draw () { }

        internal void process_update (float delta_time) {
            foreach (GameObject object in _objects) {
                object.process_update (delta_time);
            }

            update (delta_time);
        }

        internal void process_draw () {
            foreach (GameObject object in _objects) {
                object.process_draw ();
            }

            draw ();
        }
    }
}

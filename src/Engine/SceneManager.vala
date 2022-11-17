using Virgil.Scenes;

namespace Virgil.Engine {
    internal class SceneManager {
        //  Singleton
        private static SceneManager? _instance;
        public static SceneManager instance {
            get {
                if (_instance != null) {
                    return _instance;
                } else {
                    _instance = new SceneManager ();
                    return _instance;
                }
            }
        }

        private List<Scene> _scenes;

        private unowned Scene? _active_scene;

        public SceneManager () {
            _scenes = new List<Scene> ();

            _active_scene = null;
        }

        public unowned Scene get_active_scene () {
            return _active_scene;
        }

        public unowned Scene? load_scene (int id) {
            if (id > _scenes.length ()) {
                warning ("Tried to load scene with ID %d, no scene with ID found!", id);

                return null;
            }

            return _active_scene = _scenes.nth_data (id);
        }

        public int add_scene (owned Scene scene) {
            int current_index = (int)_scenes.length ();

            _scenes.append (scene);

            return current_index;
        }

        public void run (float delta_time) {
            if (_active_scene == null) return;

            _active_scene.process_update (delta_time);

            _active_scene.process_draw ();
        }
    }
}

using Virgil.Scenes;

namespace Virgil.Engine {
    internal class SceneLoader {
        private List<Scene> _scenes;

        private unowned Scene? _active_scene;

        public SceneLoader () {
            _scenes = new List<Scene> ();

            _active_scene = null;
        }

        public uint register (owned Scene scene) {
            uint current_index = _scenes.length ();

            _scenes.append (scene);
            scene.register ();

            return current_index;
        }

        public void run (float delta_time) {
            if (_active_scene == null) return;

            _active_scene.process_update (delta_time);
        }

        public void draw () {
            if (_active_scene == null) return;

            _active_scene.process_draw ();
        }

        public bool set_active_scene (uint id) {
            if (id > _scenes.length ()) {
                warning ("Scene ID %ud is out of range!", id);

                return false;
            }

            _active_scene.end ();

            _active_scene = _scenes.nth_data (id);

            return true;
        }
    }
}

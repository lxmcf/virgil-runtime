namespace Virgil.Scenes {
    public class SceneManager {
        private List<Scene> _scenes;

        private unowned Scene? _current_scene;

        public SceneManager () {
            _scenes = new List<Scene> ();

            _current_scene = null;
        }

        public void add_scene (owned Scene scene) {
            _scenes.append (scene);
        }
    }
}
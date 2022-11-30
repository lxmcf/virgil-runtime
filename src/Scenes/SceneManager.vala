using Virgil.Engine;

//  NOTE: Using as a wrapper for now
namespace Virgil.Scenes {
    public class SceneManager {
        public static uint register_scene (owned Scene scene) {
            return Runtime.scene_loader.register (scene);
        }

        public static bool load_scene (uint id) {
            return Runtime.scene_loader.set_active_scene (id);
        }
    }
}

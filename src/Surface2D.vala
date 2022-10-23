using SDL.Video;

using Virgil.Engine;

namespace Virgil {
    public class Surface2D {
        private Texture? _texture;

        private int _width;
        private int _height;

        public Surface2D (int width, int height) {
            _create_blank_texture (width, height);
        }

        public void draw (Vector2 position) {
            EngineState engine_state = EngineState.instance;

            engine_state.sdl_renderer.copy (_texture, null, { (int)position.x, (int)position.y, _width, _height });
        }

        private void _create_blank_texture (int width, int height) {
            EngineState engine_state = EngineState.instance;

            _texture = Texture.create (engine_state.sdl_renderer, PixelRAWFormat.ABGR8888,TextureAccess.TARGET, width, height);
            _texture.set_blend_mode (BlendMode.BLEND);

            _width = width;
            _height = height;
        }
    }
}
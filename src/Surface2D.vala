using Virgil.Engine;

namespace Virgil {
    public class Surface2D {
        private SDL.Video.Texture? _texture;

        private int _width;
        private int _height;

        public Surface2D (int width, int height) {
            _create_blank_texture (width, height);
        }

        public void draw (Vector2 position) {
            Window window = Window.instance;

            window.sdl_renderer.copy (_texture, null, { (int)position.x, (int)position.y, _width, _height });
        }

        private void _create_blank_texture (int width, int height) {
            Window window = Window.instance;

            _texture = SDL.Video.Texture.create (window.sdl_renderer, SDL.Video.PixelRAWFormat.ABGR8888, SDL.Video.TextureAccess.TARGET, width, height);
            _texture.set_blend_mode (SDL.Video.BlendMode.BLEND);

            _width = width;
            _height = height;
        }
    }
}
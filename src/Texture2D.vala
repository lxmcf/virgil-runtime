using Virgil.Engine;

namespace Virgil {
    public class Texture2D{
        private SDL.Video.Texture? _texture;

        private int _width;
        private int _height;

        public Point origin;

        public Texture2D (int width, int height) {
            _create_blank_texture (width, height);
        }

        public Texture2D.from_file (string filename) {
            if (FileUtils.test (filename, GLib.FileTest.EXISTS)) {
                int width, height, channels;

                uchar* pixels = Stbi.load (filename, out width, out height, out channels);

                _create_blank_texture (width, height);

                _texture.update (null, pixels, channels * width);

                delete pixels;
            } else { return; }
        }

        public void draw (Vector2 position) {
            Window window = Window.instance;

            window.sdl_renderer.copy (_texture, null, { (int)position.x + origin.x, (int)position.y + origin.y, _width, _height });
        }

        public void set_origin (Point point) {
            origin = point;
        }

        private void _create_blank_texture (int width, int height) {
            Window window = Window.instance;

            _texture = SDL.Video.Texture.create (window.sdl_renderer, SDL.Video.PixelRAWFormat.ABGR8888, SDL.Video.TextureAccess.STATIC, width, height);
            _texture.set_blend_mode (SDL.Video.BlendMode.BLEND);

            _width = width;
            _height = height;

            origin = { 0, 0 };
        }
    }
}
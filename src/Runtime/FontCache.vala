namespace Virgil.Runtime {
    internal class FontCache {
        private static List<Raylib.Font?> _font_cache;

        public static void init () {
            _font_cache = new List<Raylib.Font?> ();
        }

        public static void clear () {
            foreach (Raylib.Font? font in _font_cache) {
                if (font == null) continue;

                Raylib.unload_font (font);
            }
        }

        public static Raylib.Font register (owned Raylib.Font font) {
            _font_cache.append (font);

            return font;
        }
    }
}

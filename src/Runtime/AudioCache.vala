namespace Virgil.Runtime {
    internal class AudioCache {
        private static List<Raylib.Sound?> _sound_cache;
        private static List<Raylib.Music?> _music_cache;

        public static void init () {
            _sound_cache = new List<Raylib.Sound?> ();
            _music_cache = new List<Raylib.Music?> ();
        }

        public static void clear () {
            foreach (Raylib.Sound? sound in _sound_cache) {
                if (sound == null) continue;

                Raylib.unload_sound (sound);
            }

            foreach (Raylib.Music? music in _music_cache) {
                if (music == null) continue;

                Raylib.unload_music_stream (music);
            }
        }

        public static Raylib.Sound register_sound (owned Raylib.Sound sound) {
            _sound_cache.append (sound);

            return sound;
        }

        public static Raylib.Music register_music (owned Raylib.Music music) {
            _music_cache.append (music);

            return music;
        }
    }
}

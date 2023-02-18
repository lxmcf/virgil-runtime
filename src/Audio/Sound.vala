namespace Virgil.Audio {
    public class Sound {
        private Raylib.Sound _sound;

        private float _volume;
        private float _pitch;
        private float _pan;

        public float volume {
            set { Raylib.set_sound_volume (_sound, value); _volume = value; }
            get { return _volume; }
        }

        public float pitch {
            set { Raylib.set_sound_pitch (_sound, value); _pitch = value; }
            get { return _pitch; }
        }

        public float pan {
            set { Raylib.set_sound_pan (_sound, value); _pan = value; }
            get { return _pan; }
        }

        public bool is_playing {
            get { return Raylib.is_sound_playing (_sound); }
        }

        public Sound (string filename) {
            _sound = Raylib.load_sound (filename);

            _volume = 1.0f;
            _pitch = 1.0f;
            _pan = 0.0f;
        }

        ~Sound () {
            Raylib.unload_sound (_sound);
        }

        public void play () {
            Raylib.play_sound (_sound);
        }

        public void stop () {
            Raylib.stop_sound (_sound);
        }

        public void pause () {
            Raylib.pause_sound (_sound);
        }

        public void resume () {
            Raylib.resume_sound (_sound);
        }
    }
}

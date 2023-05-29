using Virgil.Runtime;

namespace Virgil.Audio {
    public class Music {
        private Raylib.Music _music;

        private float _volume;
        private float _pitch;
        private float _pan;

        public float volume {
            set { Raylib.set_music_volume (_music, value); _volume = value; }
            get { return _volume; }
        }

        public float pitch {
            set { Raylib.set_music_pitch (_music, value); _pitch = value; }
            get { return _pitch; }
        }

        public float pan {
            set { Raylib.set_music_pan (_music, value); _pan = value; }
            get { return _pan; }
        }

        public float position {
            set { Raylib.seek_music_stream (_music, value); }
            get { return Raylib.get_music_time_played (_music); }
        }

        public float length {
            get { return Raylib.get_music_time_length (_music); }
        }

        public bool is_playing {
            get { return Raylib.is_music_stream_playing (_music); }
        }

        public Music (string filename) {
            _music = Raylib.load_music_stream (filename);

            _volume = 1.0f;
            _pitch = 1.0f;
            _pan = 0.0f;
        }

        ~Music () {
            Raylib.unload_music_stream (_music);
        }

        public void play () {
            Raylib.play_music_stream (_music);
        }

        public void stop () {
            Raylib.stop_music_stream (_music);
        }

        public void pause () {
            Raylib.pause_music_stream (_music);
        }

        public void resume () {
            Raylib.resume_music_stream (_music);
        }
    }
}

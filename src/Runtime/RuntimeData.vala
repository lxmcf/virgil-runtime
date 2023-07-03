namespace Virgil.Runtime {
    internal struct RuntimeConfig {
        //  Flags
        public bool show_version { get; internal set; }
        public bool show_fps { get; internal set; }

        //  Files
        public string working_directory { get; internal set; }
        public string game_file { get; internal set; }

        //  Targets
        public int target_fps { get; internal set; }
    }
}

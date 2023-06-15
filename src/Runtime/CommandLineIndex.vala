namespace Virgil.Runtime {
    public class CommandLineIndex {
        private OptionGroup _group;

        private OptionEntry[] _entries;

        private bool _is_registered;
        private int _entry_count;

        public CommandLineIndex (string module_name, string help_description) {
            string formatted_name = module_name.replace (" ", "-");

            _is_registered = false;
            _entry_count = 0;

            _group = new OptionGroup (formatted_name.down (), module_name + " Options", help_description);
            _entries = new OptionEntry[1]; // NOTE: Consider moving to a list that is converted at registration
        }

        public OptionEntry[] get_entries () {
            OptionEntry[] temp = _entries.copy ();
            temp[_entry_count] = { null };

            return temp;
        }

        public void add_entry (owned OptionEntry entry) {
            if (_is_registered) {
                warning ("Cannot add entry to registered command line context!");
                return;
            }

            _entries[_entry_count++] = entry;
            _entries.resize (_entry_count + 1);
        }

        public void register () {
            if (_is_registered) {
                warning ("Command line context already registered!");
                return;
            }

            _is_registered = true;

            _entries[_entry_count] = { null };
            _group.add_entries (_entries);
        }
    }
}

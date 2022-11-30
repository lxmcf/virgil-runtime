namespace Virgil {
    // TODO: Impliment collision resolution: Likely linked lists
    public class HashMap <T> {
        private T[] _data;

        public HashMap (int size = 1024) {
            _data = new T[size];
        }

        public bool add_item (string key, owned T item) {
            ulong index = hash_sdbm (key) % _data.length;

            if (_data[index] != null) return false;

            _data[index] = item;

            //  True if item added
            return true;
        }

        public T? get_item (string key) {
            ulong index = hash_sdbm (key) % _data.length;

            return _data[index];
        }

        private ulong hash_sdbm (string key) {
            char character = 0;
            ulong hash = 0;

            for (long i = 0; i < key.length; i++) {
                character = key.get (i);

                hash = character + (hash << 6) + (hash << 16) - hash;
            }

            return hash;
        }
    }
}

namespace Virgil {
    public class Collider2D : Component {
        private static List<Collider2D> _active_colliders = new List<Collider2D> ();

        public Collider2D () {
            base ();

            _active_colliders.append (this);
        }

        ~Collider2D () {
            _active_colliders.remove (this);

            warning ("%s destroyed!", name);
        }

        public override void update () {
            print ("Array Size: %u\n", _active_colliders.length ());
        }
    }
}

namespace Virgil {
    public class Collider2D : Component {
        private static List<Collider2D> _active_colliders = new List<Collider2D> ();
        private uint id;

        protected Colour colour;
        protected Vector2 position;

        ~Collider2D () {
            _active_colliders.remove (this);
        }

        public override void start () {
            id = _active_colliders.length ();
            _active_colliders.append (this);

            colour = Colour.WHITE;

            setup ();
        }

        public override void update () {
            colour = Colour.WHITE;

            position = transform.position;

            foreach (Collider2D collider in _active_colliders) {
                if (id == collider.id) continue;

                if (process_collision (collider)) {
                    object.collide_2D (collider);
                    colour = Colour.RED;
                }
            }
        }

        //  FIXME: Not final
        public virtual bool process_collision (Collider2D collider) { return false; }

        public virtual void setup () { }
    }
}

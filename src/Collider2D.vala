namespace Virgil {
    public class Collider2D : Component {
        private static List<Collider2D> _active_colliders = new List<Collider2D> ();
        private uint id;

        protected Vector2 position;
        protected Colour _colour;

        ~Collider2D () {
            _active_colliders.remove (this);
        }

        public override void start () {
            id = _active_colliders.length ();
            _active_colliders.append (this);

            _colour = Colour.WHITE;

            setup ();
        }

        public override void update () {
            position = object.get_relative_position ();
            _colour = Colour.WHITE;

            foreach (Collider2D collider in _active_colliders) {
                if (id == collider.id) continue;

                if (process_collision (collider)) {
                    object.collide_2D (collider);

                    _colour = Colour.RED;
                }
            }
        }

        //  FIXME: Not final
        public virtual bool process_collision (Collider2D collider) { return false; }

        public virtual void setup () { }
    }
}

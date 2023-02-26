namespace Virgil {
    public class Collider2D : Component {
        private static List<Collider2D> _active_colliders = new List<Collider2D> ();
        private uint id;

        protected Vector2 position;
        protected Vector2 offset;

        protected Vector2 adjusted_offset;
        protected ColliderShape2D shape;

        // Remove on main builds
        protected Colour debug_colour;

        ~Collider2D () {
            _active_colliders.remove (this);
        }

        public override void start () {
            id = _active_colliders.length ();
            _active_colliders.append (this);

            offset = { 0.0f, 0.0f };
            adjusted_offset = offset;

            shape = ColliderShape2D.NULL;
            debug_colour = Colour.WHITE;

            setup ();
        }

        public override void update () {
            adjusted_offset = Vector2.multiply (offset, object.relative_transform.scale);
            adjusted_offset = Vector2.abs (adjusted_offset);

            position = Vector2.subtract (object.relative_transform.position, adjusted_offset);
            debug_colour = Colour.WHITE;

            adjust_collider ();

            foreach (Collider2D collider in _active_colliders) {
                if (id == collider.id) continue;

                if (process_collision (collider)) {
                    object.collide_2D (collider);

                    debug_colour = Colour.RED;
                }
            }
        }

        //  FIXME: Not final
        public virtual bool process_collision (Collider2D collider) { return false; }

        public virtual void setup () { }

        public virtual void adjust_collider () { }
    }
}

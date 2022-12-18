namespace Virgil {
    public class Collider2D : Component {
        private static List<Collider2D> _active_colliders = new List<Collider2D> ();
        private uint id;

        public Rectangle rect;
        public Colour colour;

        ~Collider2D () {
            _active_colliders.remove (this);

            warning ("%s destroyed!", name);
        }

        public override void start () {
            id = _active_colliders.length ();
            _active_colliders.append (this);

            rect = {
                0, 0, 64, 64
            };

            colour = Colour.WHITE;
        }

        public override void update () {
            rect.x = (int)transform.position.x;
            rect.y = (int)transform.position.y;

            colour = Colour.WHITE;

            foreach (Collider2D collider in _active_colliders) {
                if (id == collider.id) continue;
                if (Raylib.check_collision_rectangles ({ rect.x, rect.y, rect.width, rect.height }, { collider.rect.x, collider.rect.y, collider.rect.width, collider.rect.height })) {
                    colour = Colour.RED;
                }
            }
        }

        public override void draw () {
            draw_rectangle_outline (rect, colour);
        }
    }
}

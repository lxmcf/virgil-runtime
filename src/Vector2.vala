namespace Virgil {
    // NOTE: Consider moving to struct
    public class Vector2 {
        public float x;
        public float y;

        public float length {
            get {
                return Math.sqrtf ((x * x) + (y * y));
            }
        }

        public float dot (Vector2 vector) {
            return (x * vector.x) + (y * vector.y);
        }

        public Vector2 (float x, float y) {
            this.x = x;
            this.y = y;
        }

        public void subtract (Vector2 vector) {
            x -= vector.x;
            y -= vector.y;
        }

        public void multiply (Vector2 vector) {
            x *= vector.x;
            y *= vector.y;
        }

        public void divide (Vector2 vector) {
            x /= vector.x;
            y /= vector.y;
        }

        public void add (Vector2 vector) {
            x += vector.x;
            y += vector.y;
        }

        public bool equals (Vector2 vector) {
            return (x == vector.x && y == vector.y);
        }
    }
}
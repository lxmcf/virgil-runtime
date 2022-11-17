namespace Virgil {
    public struct Vector2 {
        public float x;
        public float y;

        public float length {
            get {
                return Math.sqrtf ((x * x) + (y * y));
            }
        }

        public Vector2 (float x, float y) {
            this.x = x;
            this.y = y;
        }

        public Point to_point () {
            return {
                (int)x,
                (int)y
            };
        }

        public static Vector2 subtract (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x -= vector2.x,
                vector1.y -= vector2.y
            };
        }

        public static Vector2 multiply (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x *= vector2.x,
                vector1.y *= vector2.y
            };
        }

        public static Vector2 divide (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x /= vector2.x,
                vector1.y /= vector2.y
            };
        }

        public static Vector2 add (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x += vector2.x,
                vector1.y += vector2.y
            };
        }

        public static float dot (Vector2 vector1, Vector2 vector2) {
            return (vector1.x * vector2.x) + (vector1.y * vector2.y);
        }

        public static bool equals (Vector2 vector1, Vector2 vector2) {
            return (vector1.x == vector2.x && vector1.y == vector2.y);
        }
    }
}

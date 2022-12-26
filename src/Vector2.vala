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

        public static float distance (Vector2 vector1, Vector2 vector2) {
            float direction_x = vector2.x - vector1.x;
            float direction_y = vector2.y - vector1.y;

            return Math.sqrtf ((direction_x * direction_x) + (direction_y * direction_y));
        }

        public static float direction (Vector2 vector1, Vector2 vector2) {
            float direction_x = vector2.x - vector1.x;
            float direction_y = vector2.y - vector1.y;

            float degrees = Math.atan2f (direction_y, direction_x) * Raylib.RAD2DEG;

            return (degrees <= 0) ? Math.fabsf (-degrees) : 360.0f - degrees;

        }

        //  FIXME: This is super slow...
        [Version (experimental = true)]
        public static Vector2 length_direction (float length, float rotation) {
            float adjusted_direction = rotation * Raylib.DEG2RAD;

            return {
                length * Math.cosf (adjusted_direction),
                -length * Math.sinf (adjusted_direction)
            };
        }
    }
}

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

        public inline static Vector2 subtract (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x -= vector2.x,
                vector1.y -= vector2.y
            };
        }

        public inline static Vector2 multiply (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x *= vector2.x,
                vector1.y *= vector2.y
            };
        }

        public inline static Vector2 divide (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x /= vector2.x,
                vector1.y /= vector2.y
            };
        }

        public inline static Vector2 add (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x += vector2.x,
                vector1.y += vector2.y
            };
        }

        public inline static Vector2 rotate (Vector2 vector, float degrees) {
            float sin = Math.sinf (degrees * Raylib.DEG2RAD);
            float cos = Math.cosf (degrees * Raylib.DEG2RAD);

            return {
                (cos * vector.x) - (sin * vector.y),
                (sin * vector.x) + (cos * vector.y)
            };
        }

        public inline static float dot (Vector2 vector1, Vector2 vector2) {
            return (vector1.x * vector2.x) + (vector1.y * vector2.y);
        }

        public inline static bool equals (Vector2 vector1, Vector2 vector2) {
            return (vector1.x == vector2.x && vector1.y == vector2.y);
        }

        public inline static float distance (Vector2 vector1, Vector2 vector2) {
            float direction_x = vector2.x - vector1.x;
            float direction_y = vector2.y - vector1.y;

            return Math.sqrtf ((direction_x * direction_x) + (direction_y * direction_y));
        }

        public inline static float direction (Vector2 vector1, Vector2 vector2) {
            float direction_x = vector2.x - vector1.x;
            float direction_y = vector2.y - vector1.y;

            float degrees = Math.atan2f (direction_y, direction_x) * Raylib.RAD2DEG;

            return (degrees <= 0) ? Math.fabsf (-degrees) : 360.0f - degrees;

        }

        public inline static Vector2 length_direction (float length, float rotation) {
            float adjusted_direction = rotation * Raylib.DEG2RAD;

            return {
                length * Math.cosf (adjusted_direction),
                -length * Math.sinf (adjusted_direction)
            };
        }
    }
}

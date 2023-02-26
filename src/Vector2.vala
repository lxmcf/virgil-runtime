namespace Virgil {
    public struct Vector2 {
        public const Vector2 ZERO = { 0.0f, 0.0f };
        public const Vector2 ONE = { 1.0f, 1.0f };

        public float x;
        public float y;

        public float length {
            get {
                return Math.sqrtf ((x * x) + (y * y));
            }
        }

        public inline static Vector2 abs (Vector2 vector) {
            return {
                Math.fabsf (vector.x),
                Math.fabsf (vector.y)
            };
        }

        public inline static Vector2 normalise (Vector2 vector) {
            float length = vector.length;

            if (length > 0) {
                float adjusted_length = 1.0f / length;

                return {
                    vector.x * adjusted_length,
                    vector.y * adjusted_length
                };
            }

            return Vector2.ZERO;
        }

        //----------------------------------------------------------------------------------
        // Vector based manipulation
        //----------------------------------------------------------------------------------

        public inline static Vector2 add (Vector2 vector1, Vector2 vector2) {
            return {
                vector1.x += vector2.x,
                vector1.y += vector2.y
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

        //----------------------------------------------------------------------------------
        // Value based manipulation
        //----------------------------------------------------------------------------------

        public inline static Vector2 add_value (Vector2 vector, float value) {
            return {
                vector.x += value,
                vector.y += value
            };
        }

        public inline static Vector2 subtract_value (Vector2 vector1, float value) {
            return {
                vector1.x -= value,
                vector1.y -= value
            };
        }

        public inline static Vector2 multiply_value (Vector2 vector1, float value) {
            return {
                vector1.x *= value,
                vector1.y *= value
            };
        }

        public inline static Vector2 divide_value (Vector2 vector1, float value) {
            return {
                vector1.x /= value,
                vector1.y /= value
            };
        }

        //----------------------------------------------------------------------------------
        // Vectr based math
        //----------------------------------------------------------------------------------

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

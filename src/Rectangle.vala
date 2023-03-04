namespace Virgil {
    public struct Rectangle {
        public const Rectangle SQUARE_32 = { 0.0f, 0.0f, 32.0f, 32.0f };
        public const Rectangle SQUARE_64 = { 0.0f, 0.0f, 64.0f, 64.0f };

        public float x;
        public float y;
        public float width;
        public float height;

        public float left {
            get { return x; }
        }

        public float right {
            get { return x + width; }
        }

        public float top {
            get { return y; }
        }

        public float bottom {
            get { return y + height; }
        }

        public Vector2 center {
            get { return { x + (width / 2), y + (height / 2) }; }
        }

        public static inline Rectangle scale (Rectangle rectangle, float scale) {
            return { rectangle.x, rectangle.y, rectangle.width * scale, rectangle.height * scale };
        }

        public static inline Rectangle scale_vector (Rectangle rectangle, Vector2 scale) {
            return { rectangle.x, rectangle.y, rectangle.width * scale.x, rectangle.height * scale.y };
        }
    }
}

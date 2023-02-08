namespace Virgil {
    public struct Rectangle {
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

        public const Rectangle SQUARE_32 = { 0.0f, 0.0f, 32.0f, 32.0f };
        public const Rectangle SQUARE_64 = { 0.0f, 0.0f, 64.0f, 64.0f };
    }
}

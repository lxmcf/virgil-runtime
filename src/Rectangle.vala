namespace Virgil {
    public struct Rectangle {
        public int x;
        public int y;
        public int width;
        public int height;

        public int left {
            get { return x; }
        }

        public int right {
            get { return x + width; }
        }

        public int top {
            get { return y; }
        }

        public int bottom {
            get { return y + height; }
        }

        public const Rectangle SQUARE_32 = { 0, 0, 32, 32 };
        public const Rectangle SQUARE_64 = { 0, 0, 64, 64 };
    }
}

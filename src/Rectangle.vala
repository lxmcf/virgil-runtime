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

        public Rectangle (int x, int y, int width, int height) {
            this.x = x;
            this.y = y;

            this.width = width;
            this.height = height;
        }
    }
}
namespace Virgil {
    public struct Point {
        int x;
        int y;

        public Point (int x, int y) {
            this.x = x;
            this.y = y;
        }

        public Vector2 to_vector2 () {
            return { x, y };
        }
    }
}

namespace Virgil.Engine {
    //  Vector generic
    public struct Vector2<T> {
        public T x;
        public T y;
    }

    //  Vector float
    public struct Vector2f {
        public float x;
        public float y;

        public Vector2f (float x = 0, float y = 0) {
            this.x = x;
            this.y = y;
        }

        public string to_string () {
            return @"{ $(x.to_string ()), $(y.to_string ()) }";
        }
    }

    //  Vector double
    public struct Vector2d {
        public double x;
        public double y;

        public Vector2d (double x = 0, double y = 0) {
            this.x = x;
            this.y = y;
        }

        public string to_string () {
            return @"{ $(x.to_string ()), $(y.to_string ()) }";
        }
    }

    // Vector integer
    public struct Vector2i {
        public int x;
        public int y;

        public Vector2i (int x = 0, int y = 0) {
            this.x = x;
            this.y = y;
        }

        public string to_string () {
            return @"{ $(x.to_string ()), $(y.to_string ()) }";
        }
    }
}
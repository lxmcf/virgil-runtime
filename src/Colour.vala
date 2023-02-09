namespace Virgil {
    public struct Colour {
        public const Colour WHITE = { 255, 255, 255, 255 };
        public const Colour BLACK = { 0, 0, 0, 255 };

        public const Colour RED = { 255, 0, 0, 255 };
        public const Colour GREEN = { 0, 255, 0, 255 };
        public const Colour BLUE = { 0, 0, 255, 255 };

        public uchar r;
        public uchar g;
        public uchar b;
        public uchar a;
    }
}

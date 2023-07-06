namespace Virgil {
    public struct Vector4 {
        public const Vector4 MIN = { float.MIN, float.MIN, float.MIN, float.MIN };
        public const Vector4 MAX = { float.MAX, float.MAX, float.MAX, float.MAX };

        public const Vector4 ZERO = { 0.0f, 0.0f, 0.0f, 0.0f};
        public const Vector4 ONE = { 1.0f, 1.0f, 1.0f, 1.0f };

        public float x;
        public float y;
        public float z;
        public float w;
    }
}

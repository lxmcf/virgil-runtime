namespace Virgil {
    public struct Vector3 {
        public const Vector3 MIN = { float.MIN, float.MIN, float.MIN };
        public const Vector3 MAX = { float.MAX, float.MAX, float.MAX };

        public const Vector3 ZERO = { 0.0f, 0.0f, 0.0f };
        public const Vector3 ONE = { 1.0f, 1.0f, 1.0f };

        public float x;
        public float y;
        public float z;
    }
}

namespace Virgil {
    public class Transform {
        public Vector2 position;
        public Vector2 scale;

        public float rotation;

        public Transform () {
            position = { 0.0f, 0.0f };
            scale = { 1.0f, 1.0f };

            rotation = 0.0f;
        }

        public void translate (Vector2 vector) {
            position = Vector2.add (position, vector);
        }

        public Transform copy () {
            Transform transform = new Transform ();

            transform.position = position;
            transform.scale = scale;

            transform.rotation = rotation;

            return transform;
        }
    }
}

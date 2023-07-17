namespace Virgil {
    public static bool point_in_rectangle (Vector2 point, Rectangle rectangle) {
        bool result = false;

        if ((point.x >= rectangle.x) && (point.x <= rectangle.x + rectangle.width) && (point.y >= rectangle.y) && (point.y <= rectangle.y + rectangle.height)) {
            result = true;
        }

        return result;
    }

    public static bool point_in_circle (Vector2 point, Vector2 position, float radius) {
        float radii = radius + radius;
        bool result = false;

        float distance = Vector2.distance (point, position);

        if (distance <= radii) result = true;

        return result;
    }
}

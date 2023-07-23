namespace Virgil {
    public static void draw_pixel (Vector2 position, Colour colour = Colour.WHITE) {
        Raylib.draw_pixel_vector (
            { position.x, position.y },
            { colour.r, colour.g, colour.b, colour.a }
        );
    }

    public static void draw_line (Vector2 start, Vector2 end, Colour colour = Colour.WHITE) {
        Raylib.draw_line_vector (
            { start.x, start.y }, {end.x, end.y},
            { colour.r, colour.g, colour.b, colour.a }
        );
    }

    public static void draw_rectangle (Rectangle rectangle, Colour colour = Colour.WHITE) {
        Raylib.draw_rectangle_rect (
            { rectangle.x, rectangle.y, rectangle.width, rectangle.height },
            { colour.r, colour.g, colour.b, colour.a }
        );
    }

    //  NOTE: Used to make lines consistant, likely need to merge a change to Raylib
    public static void draw_rectangle_outline (Rectangle rectangle, Colour colour = Colour.WHITE) {
        draw_line ({ rectangle.x, rectangle.top }, { rectangle.right, rectangle.top }, colour);
        draw_line ({ rectangle.x, rectangle.bottom }, { rectangle.right, rectangle.bottom }, colour);
        draw_line ({ rectangle.left, rectangle.y }, { rectangle.left, rectangle.bottom }, colour);
        draw_line ({ rectangle.right, rectangle.y }, { rectangle.right, rectangle.bottom }, colour);
    }

    public static void draw_circle (Vector2 position, float radius, Colour colour = Colour.WHITE) {
        Raylib.draw_circle_vector (
            { position.x, position.y }, radius,
            { colour.r, colour.g, colour.b, colour.a }
        );
    }

    public static void draw_circle_outline (Vector2 position, float radius, Colour colour = Colour.WHITE) {
        Raylib.draw_circle_sector_lines (
            { position.x, position.y }, radius, 0, 360, 36,
            { colour.r, colour.g, colour.b, colour.a }
        );
    }

    public static void draw_polygon_outline (Vector2[] vertices, Colour colour = Colour.WHITE) {
        for (int i = 0; i < vertices.length; i++) {
            Vector2 start = vertices[i];
            Vector2 end = vertices[(i + 1) % vertices.length];

            Raylib.draw_line_vector ({ start.x, start.y }, { end.x, end.y }, { colour.r, colour.g, colour.b, colour.a });
        }
    }

    public static void draw_clear (Colour colour) {
        int width = Raylib.get_screen_width ();
        int height = Raylib.get_screen_height ();

        Raylib.draw_rectangle (0, 0, width, height, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_clear_alpha (Colour colour, float alpha) {
        float adjusted_alpha = alpha * 255;

        draw_clear ({ colour.r, colour.g, colour.g, (uchar)adjusted_alpha });
    }
}

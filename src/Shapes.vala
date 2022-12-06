//  { colour.r, colour.g, colour.b, colour.a }
//  Colour colour = Colour.WHITE

namespace Virgil {
    public static void draw_pixel (Vector2 position, Colour colour = Colour.WHITE) {
        Raylib.draw_pixel_vector ({ position.x, position.y }, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_line (Vector2 start, Vector2 end, Colour colour = Colour.WHITE) {
        Raylib.draw_line_vector ({ start.x, start.y }, {end.x, end.y}, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_rectangle (Rectangle rectangle, Colour colour = Colour.WHITE) {
        Raylib.draw_rectangle (rectangle.x, rectangle.y, rectangle.width, rectangle.height, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_rectangle_outline (Rectangle rectangle, Colour colour = Colour.WHITE) {
        Raylib.draw_rectangle_lines (rectangle.x, rectangle.y, rectangle.width, rectangle.height, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_circle (Vector2 center, float radius, Colour colour = Colour.WHITE) {
        Raylib.draw_circle_vector ({ center.x, center.y }, radius, { colour.r, colour.g, colour.b, colour.a });
    }

    public static void draw_circle_outline (Vector2 center, float radius, Colour colour = Colour.WHITE) {
        Raylib.draw_circle_lines ((int)center.x, (int)center.y, radius, { colour.r, colour.g, colour.b, colour.a });
    }
}

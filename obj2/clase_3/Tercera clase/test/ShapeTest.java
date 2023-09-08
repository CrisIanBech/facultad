import static org.junit.jupiter.api.Assertions.*;

import ar.edu.unq.po2.tp3.Point;
import ar.edu.unq.po2.tp3.Rectangle;
import ar.edu.unq.po2.tp3.Square;
import org.junit.jupiter.api.Test;

public class ShapeTest {
    @Test
    public void testRectangle() {
        Rectangle rectangle = new Rectangle(new Point(1, 1), 3, 5);
        assertEquals(15, rectangle.getArea());
        assertEquals(16, rectangle.getPerimeter());
        assertTrue(rectangle.isHorizontal());
        assertFalse(rectangle.isVertical());
    }

    @Test
    public void testSquare() {
        Square square = new Square(new Point(1, 1), 5);
        assertEquals(25, square.getArea());
        assertEquals(20, square.getPerimeter());
        assertFalse(square.isHorizontal());
        assertFalse(square.isVertical());
    }

}
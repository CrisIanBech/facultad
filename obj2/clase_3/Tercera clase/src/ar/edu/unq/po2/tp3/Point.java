package ar.edu.unq.po2.tp3;

public class Point {

    private int x;
    private int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public Point() {
        this(0, 0);
    }

    public void moveTo(int newX, int newY) {
        this.x = newX;
        this.y = newY;
    }

    public Point sum(Point anotherPoint) {
        return new Point(this.getX() + anotherPoint.getX(), this.getY()+ anotherPoint.getY());
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}

package ar.edu.unq.po2.tp3;

public class Rectangle {

    private Point origin;
    private int height;
    private int weight;

    public Rectangle(Point origin, int height, int weight) {
        this.origin = origin;
        this.height = height;
        this.weight = weight;
    }

    public int getArea() {
        return height * weight;
    }

    public int getPerimeter() {
        return height * 2 + weight * 2;
    }

    public boolean isVertical() {
        return height > weight;
    }

    public boolean isHorizontal() {
        return weight > height;
    }

}

package org.example;

public class Posicion {
    private int x;
    private int y;

    public Posicion(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getX() {
        return x;
    }

    @Override
    protected Posicion clone() {
        return new Posicion(getX(), getY());
    }

    public int getY() {
        return y;
    }

    public void avanzarEnX(int distancia) {
        this.x = x + distancia;
    }

    public void avanzarEnY(int distancia) {
        this.y = y + distancia;
    }
}

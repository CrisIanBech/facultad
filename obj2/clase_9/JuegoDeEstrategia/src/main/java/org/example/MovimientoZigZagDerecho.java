package org.example;

public class MovimientoZigZagDerecho extends MovimientoState {
    @Override
    Posicion posicionAlSerMovida(Posicion posicion) {
        return new Posicion(posicion.getX() + 1, posicion.getY() + 1);
    }

    @Override
    MovimientoState getProximoMovimiento() {
        return new MovimientoZigZagIzquierdo();
    }
}

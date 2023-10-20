package org.example;

public abstract class MovimientoState {
    abstract Posicion posicionAlSerMovida(Posicion posicion);
    abstract MovimientoState getProximoMovimiento();
}

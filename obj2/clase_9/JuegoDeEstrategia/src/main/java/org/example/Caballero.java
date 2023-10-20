package org.example;

public class Caballero extends Personaje {
    private MovimientoState movimiento;

    public Caballero(Posicion posicion) {
        super(posicion);
    }

    @Override
    public void avanzar() {
        this.setPosicion(movimiento.posicionAlSerMovida(getPosicion()));
        this.movimiento = movimiento.getProximoMovimiento();
    }
}

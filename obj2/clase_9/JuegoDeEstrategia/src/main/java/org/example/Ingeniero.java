package org.example;

public class Ingeniero extends Personaje {
    private Mapa mapa;
    public Ingeniero(Posicion posicion, Mapa mapa) {
        super(posicion);
        this.mapa = mapa;
    }
    @Override
    public void avanzar() {
        getPosicion().avanzarEnY(1);
        ponerLosaSiDebe();
    }
    private void ponerLosaSiDebe() {
        if(!mapa.tieneLosaEn(getPosicion())){
            mapa.ponerLosaEn(getPosicion());
        }
    }
}

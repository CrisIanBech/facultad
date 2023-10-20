package org.example;

public class Ejercito implements Peloton {
    private Personaje aliado;
    private Peloton peloton;

    public Ejercito(Personaje aliado, Peloton peloton) {
        this.aliado = aliado;
        this.peloton = peloton;
    }

    @Override
    public void avanzar() {
        aliado.avanzar();
        peloton.avanzar();
    }
}

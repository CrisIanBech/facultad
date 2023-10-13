package org.example;

public class Jugada implements Comparable<Jugada> {
    private Combinacion combinacion;
    private Carta primeraCartaJugada;
    private Carta segundaCartaJugada;
    private Carta terceraCartaJugada;
    private Carta cuartaCartaJugada;
    private Carta quintaCartaJugada;

    public Jugada(Combinacion combinacion, Carta primeraCartaJugada, Carta segundaCartaJugada, Carta terceraCartaJugada, Carta cuartaCartaJugada, Carta quintaCartaJugada) {
        this.combinacion = combinacion;
        this.primeraCartaJugada = primeraCartaJugada;
        this.segundaCartaJugada = segundaCartaJugada;
        this.terceraCartaJugada = terceraCartaJugada;
        this.cuartaCartaJugada = cuartaCartaJugada;
        this.quintaCartaJugada = quintaCartaJugada;
    }

    public int getSumaDeCartas() {
        return ContadorDeCartas.contarPuntosCartas(primeraCartaJugada, segundaCartaJugada, terceraCartaJugada, cuartaCartaJugada, quintaCartaJugada);
    }

    public Combinacion getCombinacion() {
        return combinacion;
    }

    @Override
    public int compareTo(Jugada otraJugada) {
        int combinationValue = combinacion.ordinal() - otraJugada.getCombinacion().ordinal();
        if(combinationValue != 0) return combinationValue;
        return getSumaDeCartas() - otraJugada.getSumaDeCartas();
    }
}

package org.example;

public class Carta implements Comparable<Carta> {

    private ValorCarta valor;
    private Palo palo;
    private Color color;

    public Carta(ValorCarta valor, Palo palo, Color color) {
        this.valor = valor;
        this.palo = palo;
        this.color = color;
    }

    public ValorCarta getValor() {
        return valor;
    }

    public Palo getPalo() {
        return palo;
    }

    public Color getColor() {
        return color;
    }

    @Override
    public int compareTo(Carta carta) {
        return getValor().ordinal() - carta.getValor().ordinal();
    }
}

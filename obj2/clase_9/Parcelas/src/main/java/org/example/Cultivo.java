package org.example;

public class Cultivo implements Parcela {
    private int gananciaAnual;

    public Cultivo(int gananciaAnual) {
        this.gananciaAnual = gananciaAnual;
    }

    @Override
    public double gananciaAnual() {
        return gananciaAnual;
    }
}

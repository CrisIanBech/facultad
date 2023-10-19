package org.example;

public class ParcelaCultivoSingular implements Parcela {

    private Cultivo cultivo;

    public ParcelaCultivoSingular(Cultivo cultivo) {
        this.cultivo = cultivo;
    }

    @Override
    public double gananciaAnual() {
        return cultivo.getGananciaAnual();
    }
}

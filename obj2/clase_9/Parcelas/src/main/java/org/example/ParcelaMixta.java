package org.example;

public class ParcelaMixta implements Parcela {

    private Parcela regionSuperiorIzquierda;
    private Parcela regionSuperiorDerecha;
    private Parcela regionInferiorIzquierda;
    private Parcela regionInferiorDerecha;

    public ParcelaMixta(Parcela regionSuperiorIzquierda, Parcela regionSuperiorDerecha, Parcela regionInferiorIzquierda, Parcela regionInferiorDerecha) {
        this.regionSuperiorIzquierda = regionSuperiorIzquierda;
        this.regionSuperiorDerecha = regionSuperiorDerecha;
        this.regionInferiorIzquierda = regionInferiorIzquierda;
        this.regionInferiorDerecha = regionInferiorDerecha;
    }

    @Override
    public double gananciaAnual() {
        return gananciaDeTodasLasParcelas() / 4;
    }

    private double gananciaDeTodasLasParcelas() {
        return regionSuperiorDerecha.gananciaAnual() + regionSuperiorIzquierda.gananciaAnual()
                + regionInferiorDerecha.gananciaAnual() + regionInferiorIzquierda.gananciaAnual();
    }

    public void agregarCultivoEnRegionSuperiorIzquierda(Parcela parcela) {
        regionSuperiorIzquierda = parcela;
    }

    public void agregarCultivoEnRegionInferiorIzquierda(Parcela parcela) {
        regionInferiorIzquierda = parcela;
    }

    public void agregarCultivoEnRegionSuperiorDerecha(Parcela parcela) {
        regionSuperiorDerecha = parcela;
    }

    public void agregarCultivoEnRegionInferiorDerecha(Parcela parcela) {
        regionInferiorDerecha = parcela;
    }
}

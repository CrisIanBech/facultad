package org.example;

public abstract class SolicitudDeCredito {
    private Cliente prestario;
    private double montoSolicitado;
    private int plazoEnMeses;

    public SolicitudDeCredito(Cliente prestario, double montoSolicitado, int plazoEnMeses) {
        this.prestario = prestario;
        this.montoSolicitado = montoSolicitado;
        this.plazoEnMeses = plazoEnMeses;
    }

    public Cliente getPrestario() {
        return prestario;
    }

    public double getMontoSolicitado() {
        return montoSolicitado;
    }

    public int getPlazoEnMeses() {
        return plazoEnMeses;
    }

    public double getMontoCuotaMensual() {
        return getMontoSolicitado() / getPlazoEnMeses();
    }

    public abstract boolean esAceptable();
}

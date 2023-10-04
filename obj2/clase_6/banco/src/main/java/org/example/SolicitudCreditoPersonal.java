package org.example;

public class SolicitudCreditoPersonal extends SolicitudDeCredito {
    private static final double SUELDO_NETO_MINIMO = 15000;
    private static final double RELACION_SUELDO_MAXIMO_A_SACAR = 0.7;

    public SolicitudCreditoPersonal(Cliente prestario, double montoSolicitado, int plazoEnMeses) {
        super(prestario, montoSolicitado, plazoEnMeses);
    }

    @Override
    public boolean esAceptable() {
        return prestarioTieneIngresosAnualesSuficientes() && prestarioTieneIngresosMensualesSuficientes();
    }

    private boolean prestarioTieneIngresosAnualesSuficientes() {
        return getPrestario().getSueldoNetoAnual() >= SUELDO_NETO_MINIMO;
    }

    private boolean prestarioTieneIngresosMensualesSuficientes() {
        return getMontoCuotaMensual() <= topeMaximoImporteMensualASacar();
    }

    private double topeMaximoImporteMensualASacar() {
        return getPrestario().getSueldoMensual() * RELACION_SUELDO_MAXIMO_A_SACAR;
    }
}

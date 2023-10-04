package org.example;

public class SolicitudCreditoHipotecario extends SolicitudDeCredito {

    private Garantia garantia;

    public SolicitudCreditoHipotecario(Garantia garantia, Cliente prestario, double montoSolicitado, int plazoEnMeses) {
        super(prestario, montoSolicitado, plazoEnMeses);
        this.garantia = garantia;
    }

    @Override
    public boolean esAceptable() {
        return prestarioPuedePagarMontoMensual() && montoTotalNoSuperaValorDeGarantia() && prestarioConEdadAcorde();
    }

    private boolean prestarioPuedePagarMontoMensual() {
        return getMontoCuotaMensual() <= getPrestario().getSueldoMensual() * 0.5;
    }

    private boolean montoTotalNoSuperaValorDeGarantia() {
        return getMontoSolicitado() <= garantia.getValorFiscal() * 0.7;
    }

    private boolean prestarioConEdadAcorde() {
        return getPrestario().getEdad() + (getPlazoEnMeses() / 12) < 65;
    }
}

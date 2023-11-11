package org.example;

public class SuscripcionPartido {

    private SuscriptorPartido suscriptorPartido;

    public SuscripcionPartido(SuscriptorPartido suscriptorPartido) {
        this.suscriptorPartido = suscriptorPartido;
    }

    public SuscriptorPartido getSuscriptorPartido() {
        return suscriptorPartido;
    }

    public final boolean valeParaResultado(Resultado resultado) {
        return coincidenContrincantes(resultado) && coincideDeporte(resultado);
    }

    protected boolean coincideDeporte(Resultado resultado) {
        return true;
    }

    protected boolean coincidenContrincantes(Resultado resultado) {
        return true;
    }

}

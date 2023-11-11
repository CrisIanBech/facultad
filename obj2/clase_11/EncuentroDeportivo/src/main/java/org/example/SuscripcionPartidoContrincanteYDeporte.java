package org.example;


public class SuscripcionPartidoContrincanteYDeporte extends SuscripcionPartido {

    private Deporte deporteSuscrito;
    private String contrincanteSuscrito;
    private Comparador<Deporte> comparadorDeporte;
    private Comparador<String> comparadorContrincante;

    public SuscripcionPartidoContrincanteYDeporte(SuscriptorPartido suscriptorPartido) {
        super(suscriptorPartido);
        comparadorDeporte = new NullishTrueComparador<>();
        comparadorContrincante = new NullishTrueComparador<>();
    }

    public void setDeporteSuscrito(Deporte deporteSuscrito) {
        this.deporteSuscrito = deporteSuscrito;
        this.comparadorDeporte = new Comparador<>();
    }

    public void setContrincante(String contrincante) {
        this.contrincanteSuscrito = contrincante;
        this.comparadorContrincante = new Comparador<>();
    }

    @Override
    protected boolean coincideDeporte(Resultado resultado) {
        return comparadorDeporte.equals(resultado.getDeporte(), deporteSuscrito);
    }

    @Override
    protected boolean coincidenContrincantes(Resultado resultado) {
        return resultado.getContrincantes().stream().anyMatch(contrincante -> comparadorContrincante.equals(contrincante, contrincanteSuscrito));
    }

}

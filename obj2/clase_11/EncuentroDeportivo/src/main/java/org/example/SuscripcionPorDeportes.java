package org.example;

import java.util.List;

public class SuscripcionPorDeportes extends SuscripcionPartido {

    private final List<Deporte> deportes;

    public SuscripcionPorDeportes(SuscriptorPartido suscriptorPartido, List<Deporte> deportes) {
        super(suscriptorPartido);
        this.deportes = deportes;
    }

    @Override
    protected boolean coincideDeporte(Resultado resultado) {
        return deportes.stream().anyMatch(deporte -> resultado.getDeporte().equals(deporte));
    }

}

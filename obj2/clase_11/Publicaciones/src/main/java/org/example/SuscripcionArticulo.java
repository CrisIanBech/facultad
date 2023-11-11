package org.example;

import java.util.List;

public class SuscripcionArticulo {

    private SuscriptorArticulo suscripcionArticuloListener;

    public SuscripcionArticulo(SuscriptorArticulo suscripcionArticuloListener) {
        this.suscripcionArticuloListener = suscripcionArticuloListener;
    }

    public SuscriptorArticulo getSuscripcionArticuloListener() {
        return suscripcionArticuloListener;
    }

    public boolean preferenciaTitulo(String titulo) { return true; }
    public boolean preferenciaAutores(List<Persona> autores) { return true; }
    public boolean preferenciaFiliales(List<Filial> filiales) { return true; }
    public boolean preferenciaTipoArticulo(TipoArticulo tipoArticulo) { return true; }
    public boolean preferenciaLugarPublicacion(LugarPublicacion lugarPublicacion) { return true; }
    public boolean preferenciaPalabrasClave(List<String> palabrasClave) { return true; }

}

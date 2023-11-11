package org.example;

import java.util.ArrayList;
import java.util.List;

public class GestorDePartidos {
    private List<Resultado> resultados;
    private List<SuscripcionPartido> suscripcionesPartidos;

    public GestorDePartidos() {
        resultados = new ArrayList<>();
        suscripcionesPartidos = new ArrayList<>();
    }

    public void suscribirseAResultados(SuscripcionPartido suscripcionPartido) {
        suscripcionesPartidos.add(suscripcionPartido);
    }

    public void agregarResultado(Resultado resultado) {
        resultados.add(resultado);
        notificarNuevoResultado(resultado);
    }

    private void notificarNuevoResultado(Resultado resultado) {
        suscripcionesPartidos.stream()
                .filter(suscripcionPartido -> suscripcionPartido.valeParaResultado(resultado))
                .forEach(suscripcionPartido -> suscripcionPartido.getSuscriptorPartido().nuevoResultado(resultado));
    }

}

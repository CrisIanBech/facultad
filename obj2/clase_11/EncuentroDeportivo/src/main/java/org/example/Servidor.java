package org.example;

import java.util.ArrayList;
import java.util.List;

public class Servidor implements SuscriptorPartido {

    private List<Deporte> deportesSuscritos;

    public Servidor() {
        this.deportesSuscritos = new ArrayList<>();
    }

    public void agregarGeneroDeporteDeInteres(Deporte deporte) {
        deportesSuscritos.add(deporte);
    }

    public void suscribirseAGestorPartidos(GestorDePartidos gestorDePartidos) {
        gestorDePartidos.suscribirseAResultados(getSuscripcionParaDeporte());
    }

    public SuscripcionPorDeportes getSuscripcionParaDeporte() {
        return new SuscripcionPorDeportes(this, deportesSuscritos);
    }

    @Override
    public void nuevoResultado(Resultado resultado) {
        // Hacer algo
    }
}

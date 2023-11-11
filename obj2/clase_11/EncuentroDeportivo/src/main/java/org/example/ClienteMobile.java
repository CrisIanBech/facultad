package org.example;

import java.util.ArrayList;
import java.util.List;

public class ClienteMobile implements SuscriptorPartido {

    SuscripcionPartidoContrincanteYDeporte suscripcion;
    private List<Deporte> deportesSuscritos;

    public ClienteMobile() {
        this.deportesSuscritos = new ArrayList<>();
        suscripcion = new SuscripcionPartidoContrincanteYDeporte(this);
    }

    public void agregarGeneroDeporteDeInteres(Deporte deporte) {
        deportesSuscritos.add(deporte);
    }

    public void suscribirseAGestorPartidos(GestorDePartidos gestorDePartidos) {
        gestorDePartidos.suscribirseAResultados(getSuscripcion());
    }

    public void setContrincante(String contrincante) {
        suscripcion.setContrincante(contrincante);
    }

    public void setDeportesSuscritos(Deporte deporte) {
        suscripcion.setDeporteSuscrito(deporte);
    }

    public SuscripcionPartidoContrincanteYDeporte getSuscripcion() {
        return suscripcion;
    }

    @Override
    public void nuevoResultado(Resultado resultado) {
        // Hacer algo
    }

}
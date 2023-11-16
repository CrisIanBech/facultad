package org.example;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class GestorQyA {

    private List<JugadorQyA> jugadores;
    private Partida partida;

    public GestorQyA() {
        this.jugadores = new ArrayList<>();
        List<String> listlists = new ArrayList<String>();
        listlists.stream().max(String::compareTo).get();

    }

    public void agregarJugadorQyA(JugadorQyA jugador) {
        if (puedeAgregarNuevoJugador()) jugadores.add(jugador);
        jugador.recibirError(new Exception("No se pudo sumar a la partida. Cantidad máxima de jugadores alcanzada (5)"));
    }

    public boolean puedeAgregarNuevoJugador() {
        return jugadores.size() <= 4;
    }

    public void empezarNuevaPartida(Partida partida) {
        this.partida = partida;
        jugadores.forEach(jugador -> jugador.partidaComenzada(partida.getPreguntas()));
    }

    public void recibirRespuesta(JugadorQyA deJugador, String paraPregunta, String respuesta) {
        if (esJugadorValido(deJugador)) {
            validarRespuestaCorrecta(deJugador, paraPregunta, respuesta);
        } else {
            deJugador.recibirError(new Exception("No estás jugando esta partida"));
        }
    }

    private void validarRespuestaCorrecta(JugadorQyA jugador, String paraPregunta, String respuesta) {
        if(!existePregunta(paraPregunta)) {
            jugador.recibirError(new Exception("No existe dicha pregunta"));
            return;
        }

        if(!partida.esRespuestaCorrecta(paraPregunta, respuesta)) {
            jugador.respuestaIncorrecta(paraPregunta);
            return;
        }

        setRespuestaCorrectaParaJugador(jugador, paraPregunta);
        notificarQueJugadorRespondioPregunta(jugador, paraPregunta);
        verificarFinalizacionPartida();
    }

    private void setRespuestaCorrectaParaJugador(JugadorQyA jugador, String paraPregunta) {
        jugador.respuestaCorrecta(paraPregunta);
        partida.marcarRespuestaCorrecta(paraPregunta, jugador);
    }

    private void verificarFinalizacionPartida() {
        if(partida.fueronRespondidasTodasLasPreguntas()) {
            notificarVictoria();
        }
    }

    private void notificarVictoria() {
        JugadorQyA jugadorGanador = getJugadorGanador();
        jugadores.forEach(jugador -> jugador.partidaFinalizada(jugadorGanador.getNombre()));
    }

    private JugadorQyA getJugadorGanador() {
        return partida.getJugadorGanador();
    }

    private boolean existePregunta(String pregunta) { return partida.getPreguntas().stream().anyMatch(pregunta::equals); }

    private void notificarQueJugadorRespondioPregunta(JugadorQyA jugador, String paraPregunta) {
        jugadores.stream()
                .filter(otrosJugadores -> otrosJugadores != jugador)
                .forEach(jugadorQueNoRespondio -> jugadorQueNoRespondio.recibirPreguntaRespondidaPorOtroJugador(jugador, paraPregunta));
    }

    public boolean esJugadorValido(JugadorQyA jugador) {
        return jugadores.stream().anyMatch(jugador::equals);
    }

}

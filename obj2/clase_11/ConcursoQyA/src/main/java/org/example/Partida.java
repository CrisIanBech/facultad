package org.example;

import java.util.List;

interface Partida {
    List<String> getPreguntas();

    boolean esRespuestaCorrecta(String paraPregunta, String respuesta);

    boolean fueronRespondidasTodasLasPreguntas();

    void marcarRespuestaCorrecta(String paraPregunta, JugadorQyA porJugador);

    JugadorQyA getJugadorGanador();
}

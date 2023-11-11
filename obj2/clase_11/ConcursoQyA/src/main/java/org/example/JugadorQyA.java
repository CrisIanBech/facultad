package org.example;

import java.util.List;

public interface JugadorQyA {
    void recibirError(Exception e);

    void partidaComenzada(List<String> preguntas);
    
    void respuestaCorrecta(String dePregunta);

    void respuestaIncorrecta(String paraPregunta);

    void recibirPreguntaRespondidaPorOtroJugador(JugadorQyA jugador, String paraPregunta);

    String getNombre();

    void partidaFinalizada(String nombre);
}

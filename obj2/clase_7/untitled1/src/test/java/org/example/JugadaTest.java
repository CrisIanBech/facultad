package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class JugadaTest {

    private Jugada primeraJugada;
    private Jugada segundaJugada;

    private Carta primeraCarta;
    private Carta segundaCarta;
    private Carta terceraCarta;
    private Carta cuartaCarta;
    private Carta quintaCarta;

    @BeforeEach
    public void setup() {
        primeraCarta = mock(Carta.class);
        segundaCarta = mock(Carta.class);
        terceraCarta = mock(Carta.class);
        cuartaCarta = mock(Carta.class);
        quintaCarta = mock(Carta.class);

        primeraJugada = new Jugada(Combinacion.Nada, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Nada, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
    }

    @Test
    public void testPoquerGanaColor() {
        primeraJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Color, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);

        assertTrue(primeraJugada.compareTo(segundaJugada) > 0);
    }

    @Test
    public void testPoquerGanaTrio() {
        primeraJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Trio, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);

        assertTrue(primeraJugada.compareTo(segundaJugada) > 0);
    }

    @Test
    public void testPoquerGanaNada() {
        primeraJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Nada, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);

        assertTrue(primeraJugada.compareTo(segundaJugada) > 0);
    }

    @Test
    public void testColorGanaTrio() {
        primeraJugada = new Jugada(Combinacion.Color, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Trio, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);

        assertTrue(primeraJugada.compareTo(segundaJugada) > 0);
    }

    @Test
    public void testPrimeraGanaPorPuntos() {
        Carta carta = mock(Carta.class);
        primeraJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);
        segundaJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, carta);

        when(primeraCarta.getValor()).thenReturn(ValorCarta.UNO);
        when(segundaCarta.getValor()).thenReturn(ValorCarta.DOS);
        when(terceraCarta.getValor()).thenReturn(ValorCarta.TRES);
        when(cuartaCarta.getValor()).thenReturn(ValorCarta.CUATRO);
        when(quintaCarta.getValor()).thenReturn(ValorCarta.K);

        when(carta.getValor()).thenReturn(ValorCarta.UNO);

        assertTrue(primeraJugada.compareTo(segundaJugada) > 0);

    }

    @Test
    public void testPrimeraPierdePorPuntos() {
        Carta carta = mock(Carta.class);
        segundaJugada = new Jugada(Combinacion.Poquer, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, carta);

        when(primeraCarta.getValor()).thenReturn(ValorCarta.UNO);
        when(segundaCarta.getValor()).thenReturn(ValorCarta.DOS);
        when(terceraCarta.getValor()).thenReturn(ValorCarta.TRES);
        when(cuartaCarta.getValor()).thenReturn(ValorCarta.CUATRO);
        when(quintaCarta.getValor()).thenReturn(ValorCarta.UNO);

        when(carta.getValor()).thenReturn(ValorCarta.TRES);

        assertTrue(primeraJugada.compareTo(segundaJugada) < 0);

    }

    @Test
    public void testEmpate() {

        when(primeraCarta.getValor()).thenReturn(ValorCarta.UNO);
        when(segundaCarta.getValor()).thenReturn(ValorCarta.DOS);
        when(terceraCarta.getValor()).thenReturn(ValorCarta.TRES);
        when(cuartaCarta.getValor()).thenReturn(ValorCarta.CUATRO);
        when(quintaCarta.getValor()).thenReturn(ValorCarta.UNO);

        assertTrue(primeraJugada.compareTo(segundaJugada) == 0);

    }

}
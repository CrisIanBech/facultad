package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

class PokerStatusTest {

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
    }


    @Test
    public void testCuatroCartasMismoPalo() {
        setCartasToPalo(Palo.Corazones);
        setCartasColorDiferente();
        when(this.quintaCarta.getPalo()).thenReturn(Palo.Diamantes);
        assertEquals(Combinacion.Poquer, PokerStatus.verificar(primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta).getCombinacion());
    }

    @Test
    public void testCartasDiferentes() {
        setCartasDiferentes();
        assertEquals(Combinacion.Nada, PokerStatus.verificar(primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta).getCombinacion());
    }

    @Test
    public void testCincoCartasMismoPalo() {
        setCartasColorDiferente();
        setCartasToPalo(Palo.Treboles);
        assertEquals(Combinacion.Poquer, PokerStatus.verificar(primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta).getCombinacion());
    }

    @Test
    public void testColor() {
        setCartasToPalo(Palo.Corazones);
        setCartasToColor(Color.NEGRO);
        assertEquals(Combinacion.Color, PokerStatus.verificar(primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta).getCombinacion());
    }

    @Test
    public void testTrio() {
        setCartasPaloYColorDiferentes();

        when(primeraCarta.getValor()).thenReturn(ValorCarta.J);
        when(segundaCarta.getValor()).thenReturn(ValorCarta.CINCO);
        when(terceraCarta.getValor()).thenReturn(ValorCarta.CINCO);
        when(cuartaCarta.getValor()).thenReturn(ValorCarta.DIEZ);
        when(quintaCarta.getValor()).thenReturn(ValorCarta.CINCO);

        when(primeraCarta.compareTo(any(Carta.class)));
        
        assertEquals(Combinacion.Trio, PokerStatus.verificar(primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta).getCombinacion());
    }

    private void setCartasDiferentes() {
        setCartasColorDiferente();
        setCartasPaloDiferentes();
        setCartasValorDiferente();
    }

    private void setCartasPaloYColorDiferentes() {
        setCartasPaloDiferentes();
        setCartasColorDiferente();
    }

    private void setCartasPaloDiferentes() {
        when(primeraCarta.getPalo()).thenReturn(Palo.Corazones);
        when(segundaCarta.getPalo()).thenReturn(Palo.Diamantes);
        when(terceraCarta.getPalo()).thenReturn(Palo.Treboles);
        when(cuartaCarta.getPalo()).thenReturn(Palo.Picas);
        when(quintaCarta.getPalo()).thenReturn(Palo.Treboles);
    }

    private void setCartasColorDiferente() {
        when(primeraCarta.getColor()).thenReturn(Color.NEGRO);
        when(segundaCarta.getColor()).thenReturn(Color.NEGRO);
        when(terceraCarta.getColor()).thenReturn(Color.NEGRO);
        when(cuartaCarta.getColor()).thenReturn(Color.ROJO);
        when(quintaCarta.getColor()).thenReturn(Color.ROJO);
    }

    private void setCartasValorDiferente() {
        when(primeraCarta.getValor()).thenReturn(ValorCarta.K);
        when(segundaCarta.getValor()).thenReturn(ValorCarta.DIEZ);
        when(terceraCarta.getValor()).thenReturn(ValorCarta.OCHO);
        when(cuartaCarta.getValor()).thenReturn(ValorCarta.TRES);
        when(quintaCarta.getValor()).thenReturn(ValorCarta.NUEVE);
    }

    private void setCartasToPalo(Palo palo) {
        when(primeraCarta.getPalo()).thenReturn(palo);
        when(segundaCarta.getPalo()).thenReturn(palo);
        when(terceraCarta.getPalo()).thenReturn(palo);
        when(cuartaCarta.getPalo()).thenReturn(palo);
        when(quintaCarta.getPalo()).thenReturn(palo);
    }

    private void setCartasToColor(Color color) {
        when(primeraCarta.getColor()).thenReturn(color);
        when(segundaCarta.getColor()).thenReturn(color);
        when(terceraCarta.getColor()).thenReturn(color);
        when(cuartaCarta.getColor()).thenReturn(color);
        when(quintaCarta.getColor()).thenReturn(color);
    }

    private void setCartasToValor(ValorCarta valor) {
        when(primeraCarta.getValor()).thenReturn(valor);
        when(segundaCarta.getValor()).thenReturn(valor);
        when(terceraCarta.getValor()).thenReturn(valor);
        when(cuartaCarta.getValor()).thenReturn(valor);
        when(quintaCarta.getValor()).thenReturn(valor);
    }

}
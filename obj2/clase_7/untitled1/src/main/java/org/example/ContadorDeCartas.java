package org.example;

import java.util.Arrays;
import java.util.List;

public class ContadorDeCartas {

    public static int contarPuntosCartas(Carta ... cartas) {
        return Arrays.stream(cartas).mapToInt(carta -> carta.getValor().ordinal() + 1).sum();
    }

}

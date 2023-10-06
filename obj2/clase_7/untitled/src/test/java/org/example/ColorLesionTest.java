package org.example;

import org.junit.jupiter.api.Test;

import java.awt.*;

import static org.junit.jupiter.api.Assertions.*;

class ColorLesionTest {

    @Test
    void getSiguienteNivelMaduracion() {
        ColorLesion colorLesion = ColorLesion.AMARILLO;
        // Ante último
        assertEquals(ColorLesion.MIEL, colorLesion.getSiguienteNivelMaduracion());
        colorLesion = colorLesion.getSiguienteNivelMaduracion();
        // Cíclico. Devuelve el primero.
        assertEquals(ColorLesion.ROJO, colorLesion.getSiguienteNivelMaduracion());
        colorLesion = colorLesion.getSiguienteNivelMaduracion();
        // Primero a segundo
        assertEquals(ColorLesion.GRIS, colorLesion.getSiguienteNivelMaduracion());
    }

}
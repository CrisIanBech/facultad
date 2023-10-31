package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EncriptadorVocalesTest {
    EncripterStrategy strategy;

    @BeforeEach
    public void setup() {
        strategy = new EncriptadorVocales();
    }

    @Test
    public void testEncriptarNombreDiego() {
        assertEquals("Doigu", strategy.encriptar("Diego"));
    }

    @Test
    public void testDesencriptarNombreDiego() {
        assertEquals("Diego", strategy.desencriptar("Doigu"));
    }
}
package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EncriptadorNumericoTest {

    EncripterStrategy strategy;

    @BeforeEach
    public void setup() {
        strategy = new EncriptadorNumerico();
    }

    @Test
    public void testEncriptarNombreDiego() {
        assertEquals("4,9,5,7,15", strategy.encriptar("Diego"));
    }

    @Test
    public void testDesencriptarNombreDiego() {
        assertEquals("diego", strategy.desencriptar("4,9,5,7,15"));
    }
}
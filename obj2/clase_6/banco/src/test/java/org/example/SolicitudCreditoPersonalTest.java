package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SolicitudCreditoPersonalTest {

    private Cliente cliente;
    private SolicitudCreditoPersonal credito;

    @BeforeEach
    public void initialize() {
        cliente = new Cliente("Pepe", "Quilmes 3425", 35, 20_000);
    }

    @Test
    public void testCumpleRequisitosCredito() {
        credito = new SolicitudCreditoPersonal(cliente, 140_000, 12);
        assertTrue(credito.esAceptable());
    }

    @Test
    public void testNoCumpleRequisitosCredito() {
        credito = new SolicitudCreditoPersonal(cliente, 300_000, 12);
        assertFalse(credito.esAceptable());
    }

}
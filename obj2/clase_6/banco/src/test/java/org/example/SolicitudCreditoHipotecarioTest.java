package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class SolicitudCreditoHipotecarioTest {

    private Cliente cliente;
    private SolicitudCreditoHipotecario credito;
    private Garantia garantia;

    @BeforeEach
    public void initialize() {
        garantia = new PropiedadInmobiliaria("Casa", "Quilmes 1451", 150_000);
        cliente = new Cliente("Pepe", "Quilmes 3425", 35, 20_000);
    }

    @Test
    public void testCumpleRequisitosCredito() {
        credito = new SolicitudCreditoHipotecario(garantia, cliente, 100_000, 12);
        assertTrue(credito.esAceptable());
    }

    @Test
    public void testNoCumpleRequisitosCredito() {
        credito = new SolicitudCreditoHipotecario(garantia, cliente, 110_000, 12);
        assertFalse(credito.esAceptable());
    }

    @Test
    public void testNoCumpleRequisitosCreditoPorEdad() {
        cliente = new Cliente("Pepe", "Quilmes 3425", 63, 20_000);
        credito = new SolicitudCreditoHipotecario(garantia, cliente, 110_000, 24);
        assertFalse(credito.esAceptable());
    }

}
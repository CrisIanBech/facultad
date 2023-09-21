package ar.edu.unq.po2;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FacturaServicioTest {
    @Test
    public void testFactura() {
        Agencia agencia = new AgenciaImpl("Edesur");
        Factura factura = new FacturaServicio(10, 20, agencia);
        factura.procesarPago();
        factura.procesarPago();
        assertEquals(200, factura.getMonto());
    }
}
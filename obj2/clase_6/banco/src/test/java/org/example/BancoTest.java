package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BancoTest {

    private Banco banco;
    private CreditoManager creditoManager;

    @BeforeEach
    public void initialize() {
        banco = new Banco();
        banco.setDineroDisponible(100_000);
        creditoManager = new CreditoManagerImpl(banco);
        banco.setCreditoManager(creditoManager);
    }

    @Test
    public void testOfrecerCredito() {
        Cliente cliente = new Cliente("Pepe", "Quilmes 1314", 32, 32500);
        SolicitudCreditoPersonal credito = new SolicitudCreditoPersonal(cliente, 15000, 12);

        banco.otorgarCredito(credito);

        assertEquals(15_000, cliente.getDineroDisponible());
        assertEquals(15_000, banco.dineroADesembolsar());
    }

    @Test
    public void testRechazaCredito() {
        Cliente cliente = new Cliente("Pepe", "Quilmes 1314", 32, 0);
        SolicitudCreditoPersonal credito = new SolicitudCreditoPersonal(cliente, 15000, 12);

        banco.otorgarCredito(credito);

        assertEquals(0, cliente.getDineroDisponible());
        assertEquals(0, banco.dineroADesembolsar());
    }

}
package org.example;

import java.util.ArrayList;
import java.util.List;

public class Banco {
    private List<Cliente> clientes;
    private CreditoManager creditoManager;
    private double dineroDisponible = 0;

    public double getDineroDisponible() {
        return dineroDisponible;
    }

    public Banco(CreditoManager creditoManager) {
        this.creditoManager = creditoManager;
        this.clientes = new ArrayList<>();
    }

    private void suscribirCliente(Cliente cliente) {
        clientes.add(cliente);
    }

    private double dineroADesembolsar() {
        return creditoManager.montoSolicitudesAceptables();
    }

    public void setDineroDisponible(double dineroDisponible) {
        this.dineroDisponible = dineroDisponible;
    }

    private void otorgarCredito(SolicitudDeCredito solicitudDeCredito) {
        creditoManager.registrarSolicitud(solicitudDeCredito);
        creditoManager.evaluarSolicitud(solicitudDeCredito);
    }

    public void pagar(Pagable pagable, double montoAPagar) {
        dineroDisponible -= montoAPagar;
        pagable.recibirPago(montoAPagar);
    }

}

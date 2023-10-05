package org.example;

import java.util.ArrayList;
import java.util.List;

public class Banco {
    private List<Cliente> clientes;
    private CreditoManager creditoManager;
    private double dineroDisponible = 0;

    public Banco() {
        this.clientes = new ArrayList<>();
    }

    public double getDineroDisponible() {
        return dineroDisponible;
    }

    public void setCreditoManager(CreditoManager creditoManager) {
        this.creditoManager = creditoManager;
    }

    public void suscribirCliente(Cliente cliente) {
        clientes.add(cliente);
    }

    public double dineroADesembolsar() {
        return creditoManager.montoSolicitudesAceptables();
    }

    public void setDineroDisponible(double dineroDisponible) {
        this.dineroDisponible = dineroDisponible;
    }

    public void otorgarCredito(SolicitudDeCredito solicitudDeCredito) {
        creditoManager.registrarSolicitud(solicitudDeCredito);
        creditoManager.evaluarSolicitud(solicitudDeCredito);
    }

    public void pagar(Pagable pagable, double montoAPagar) {
        dineroDisponible -= montoAPagar;
        pagable.recibirPago(montoAPagar);
    }

}

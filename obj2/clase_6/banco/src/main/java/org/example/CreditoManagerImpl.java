package org.example;

import java.util.ArrayList;
import java.util.List;

public class CreditoManagerImpl implements CreditoManager {

    private List<SolicitudDeCredito> solicitudDeCreditos;
    private Banco banco;


    public CreditoManagerImpl(Banco banco) {
        this.solicitudDeCreditos = new ArrayList<>();
        this.banco = banco;
    }

    @Override
    public double montoSolicitudesAceptables() {
        return solicitudDeCreditos.stream()
                .filter(SolicitudDeCredito::esAceptable)
                .mapToDouble(SolicitudDeCredito::getMontoSolicitado)
                .sum();
    }

    @Override
    public void registrarSolicitud(SolicitudDeCredito solicitudDeCredito) {
        solicitudDeCreditos.add(solicitudDeCredito);
    }

    @Override
    public void evaluarSolicitud(SolicitudDeCredito solicitudDeCredito) {
        if(solicitudDeCredito.esAceptable()) {
            pagarSolicitud(solicitudDeCredito);
        }
    }

    private void pagarSolicitud(SolicitudDeCredito solicitudDeCredito) {
        banco.pagar(solicitudDeCredito.getPrestario(), solicitudDeCredito.getMontoSolicitado());
    }
}

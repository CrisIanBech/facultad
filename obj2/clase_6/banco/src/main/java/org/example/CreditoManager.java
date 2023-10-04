package org.example;

interface CreditoManager {
    void registrarSolicitud(SolicitudDeCredito solicitudDeCredito);
    void evaluarSolicitud(SolicitudDeCredito solicitudDeCredito);
    double montoSolicitudesAceptables();
}

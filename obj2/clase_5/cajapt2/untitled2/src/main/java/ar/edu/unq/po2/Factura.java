package ar.edu.unq.po2;

abstract public class Factura implements Pagable {

    private Agencia agencia;

    public Factura(Agencia agencia) {
        this.agencia = agencia;
    }

    @Override
    public void procesarPago() {
        agencia.registrarPago(this);
    }

}

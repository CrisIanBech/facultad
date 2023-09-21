package ar.edu.unq.po2;

public class AgenciaImpl implements Agencia {

    private double totalRecaudado = 0;

    private String nombre;

    public AgenciaImpl(String nombre) {
        this.nombre = nombre;
    }

    public double getTotalRecaudado() {
        return totalRecaudado;
    }

    public String getNombre() {
        return nombre;
    }

    @Override
    public void registrarPago(Factura factura) {
        totalRecaudado += factura.getMonto();
    }

}

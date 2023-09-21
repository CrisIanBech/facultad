package ar.edu.unq.po2;

public class FacturaImpuesto extends Factura {

    private double tasaServicio;

    public FacturaImpuesto(double tasaServicio, Agencia agencia) {
        super(agencia);
        this.tasaServicio = tasaServicio;
    }

    @Override
    public double getMonto() {
        return tasaServicio;
    }
}

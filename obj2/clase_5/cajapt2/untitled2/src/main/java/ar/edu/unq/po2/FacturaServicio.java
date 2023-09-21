package ar.edu.unq.po2;

public class FacturaServicio extends Factura {

    private double costoPorUnidad;
    private int cantidadConsumida;

    public FacturaServicio(double costoPorUnidad, int cantidadConsumida, Agencia agencia) {
        super(agencia);
        this.cantidadConsumida = cantidadConsumida;
        this.costoPorUnidad = costoPorUnidad;
    }

    @Override
    public double getMonto() {
        return costoPorUnidad * cantidadConsumida;
    }

}

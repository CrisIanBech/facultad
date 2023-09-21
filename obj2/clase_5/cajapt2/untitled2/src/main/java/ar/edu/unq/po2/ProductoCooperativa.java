package ar.edu.unq.po2;

public class ProductoCooperativa extends Producto {

    public ProductoCooperativa(int stock, double precioBase, String nombre) {
        super(stock, precioBase, nombre);
    }

    @Override
    public double getMonto() {
        return super.getMonto() * 0.9;
    }

}

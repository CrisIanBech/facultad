package ar.edu.unq.po2;

public class ProductoCooperativa extends Producto {

    public ProductoCooperativa(int stock, double precioBase, String nombre) {
        super(stock, precioBase, nombre);
    }

    @Override
    public double getPrecio() {
        return super.getPrecio() * 0.9;
    }

}

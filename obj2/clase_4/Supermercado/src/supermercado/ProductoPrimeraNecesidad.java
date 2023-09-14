package supermercado;

import java.time.format.DecimalStyle;

public class ProductoPrimeraNecesidad extends Producto {

    private int descuento;


    /**
     * @param descuento: descuento a aplicar entre 1 y 100
     */
    public ProductoPrimeraNecesidad(String nombre, Double precioBase, int descuento, boolean esPreciosCuidados) {
        super(nombre, precioBase, esPreciosCuidados);
        this.descuento = descuento;
    }

    /**
     * @param descuento: descuento a aplicar entre 1 y 100
     */
    public ProductoPrimeraNecesidad(String nombre,  Double precioBase, int descuento) {
        this(nombre, precioBase, descuento, false);
    }

    @Override
    public Double getPrecio() {
        return super.getPrecio() * proporcionPrecioConDescuento();
    }

    private Double proporcionPrecioConDescuento() {
        double porcentajeDescuento = 1d / descuento;
        return 1d - porcentajeDescuento;
    }

}

package supermercado;

public class Producto {

    private String nombre;
    private Double precioBase;
    private boolean esPreciosCuidados;

    public Producto(String nombre, Double precioBase, boolean esPreciosCuidados) {
        this.nombre = nombre;
        this.precioBase = precioBase;
        this.esPreciosCuidados = esPreciosCuidados;
    }

    public Producto(String nombre, Double precioBase) {
        this(nombre, precioBase, false);
    }

    public void aumentarPrecio(Double cantidad) {
        this.precioBase += cantidad;
    }

    public Double getPrecio() {
        return precioBase;
    }

    public String getNombre() {
        return nombre;
    }

    public boolean esPrecioCuidado() {
        return esPreciosCuidados;
    }

}

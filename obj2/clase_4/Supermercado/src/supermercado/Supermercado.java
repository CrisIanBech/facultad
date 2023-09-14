package supermercado;

import java.util.ArrayList;
import java.util.List;

public class Supermercado {

    private String nombre;
    private String direccion;
    private List<Producto> productos;

    public Supermercado(String nombre, String direccion) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.productos = new ArrayList<Producto>();
    }

    public void agregarProducto(Producto producto) {
        productos.add(producto);
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getDireccion() {
        return this.direccion;
    }

    public int getCantidadDeProductos() {
        return productos.size();
    }

    public Double getPrecioTotal() {
        return productos.stream().mapToDouble(Producto::getPrecio).sum();
    }

}

package ar.edu.unq.po2;

import java.util.Collection;
import java.util.List;

public class Caja {

    public int registrarProductos(Collection<Producto> productos) {

        int precioFinal = 0;

        for (Producto producto : productos) {
            producto.decrementarStock();
            precioFinal += producto.getPrecio();
        }

        return precioFinal;

    }

}

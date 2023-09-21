package ar.edu.unq.po2;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CajaTest {

    @Test
    public void testRegistrarProductos() {

        Caja caja = new Caja();

        List<Producto> productos = new ArrayList<>(3);

        Producto arvejas = new ProductoTradicional(5, 50d, "Arvejas");
        Producto pepas = new ProductoTradicional(5, 50d, "Pepas");
        Producto tomates = new ProductoCooperativa( 10, 20d, "Tomates");

        productos.add(arvejas);
        productos.add(arvejas);
        productos.add(pepas);
        productos.add(pepas);
        productos.add(pepas);
        productos.add(tomates);

        caja.registrarProductos(productos);

        assertEquals(3, arvejas.getStock());
        assertEquals(2, pepas.getStock());
        assertEquals(9, tomates.getStock());

    }

}
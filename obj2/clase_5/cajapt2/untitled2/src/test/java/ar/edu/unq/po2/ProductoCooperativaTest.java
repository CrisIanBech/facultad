package ar.edu.unq.po2;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProductoCooperativaTest {
    @Test
    public void testProductoCooperativa() {
        Producto producto = new ProductoCooperativa(4, 20d, "Arvejas");
        producto.decrementarStock();
        producto.decrementarStock();
        assertEquals(2, producto.getStock());
        assertEquals(18d, producto.getMonto());
    }
}
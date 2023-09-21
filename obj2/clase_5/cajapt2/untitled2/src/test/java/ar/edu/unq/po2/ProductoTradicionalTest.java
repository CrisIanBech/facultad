package ar.edu.unq.po2;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProductoTradicionalTest {

    @Test
    public void testProductoTradicional() {
        Producto producto = new ProductoTradicional(4, 20d, "Arvejas");
        producto.decrementarStock();
        producto.decrementarStock();
        assertEquals(2, producto.getStock());
        assertEquals(20d, producto.getMonto());
    }
    
}
package ar.edu.unq.po2;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CajaTest {

    @Test
    public void testRegistrarPagables() {

        Caja caja = new Caja();

        List<Pagable> pagables = new ArrayList<>(3);

        Producto arvejas = new ProductoTradicional(5, 50d, "Arvejas");
        Producto pepas = new ProductoTradicional(5, 50d, "Pepas");
        Producto tomates = new ProductoCooperativa( 10, 20d, "Tomates");

        AgenciaImpl agencia = new AgenciaImpl("Edesur");

        Factura facturaImpuestos = new FacturaImpuesto(50, agencia);
        Factura facturaServicio = new FacturaServicio(5, 20, agencia);

        pagables.add(facturaImpuestos);
        pagables.add(facturaServicio);
        pagables.add(arvejas);
        pagables.add(arvejas);
        pagables.add(pepas);
        pagables.add(pepas);
        pagables.add(pepas);
        pagables.add(tomates);

        double gasto =  caja.registrar(pagables);

        assertEquals(150, agencia.getTotalRecaudado());
        assertEquals(3, arvejas.getStock());
        assertEquals(2, pepas.getStock());
        assertEquals(9, tomates.getStock());
        assertEquals(100 + 50 + 100 + 150 + 18, gasto);

    }

}
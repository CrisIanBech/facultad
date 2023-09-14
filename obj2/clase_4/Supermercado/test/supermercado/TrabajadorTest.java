package supermercado;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class TrabajadorTest {

    Trabajador trabajador;

    @Test
    void testImpuestos() {
        trabajador = new Trabajador();

        Ingreso ingresoNormal = new Ingreso("enero", "salario", 5000d);
        Ingreso ingresoReintegro = new Ingreso("enero", "reintegro", 1000d);
        IngresoHorasExtras ingresoHorasExtras = new IngresoHorasExtras("marzo", "pagos horas extras", 2000d, 4);

        trabajador.agregarIngreso(ingresoNormal);
        trabajador.agregarIngreso(ingresoReintegro);

        assertEquals(6000, trabajador.getMontoImponible());
        assertEquals(120, trabajador.getImpuestoAPagar());
        assertEquals(6000, trabajador.getTotalPercibido());

        trabajador.agregarIngreso(ingresoHorasExtras);

        assertEquals(6000, trabajador.getMontoImponible());
        assertEquals(120, trabajador.getImpuestoAPagar());
        assertEquals(8000, trabajador.getTotalPercibido());

    }
}
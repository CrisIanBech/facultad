package ar.edu.unq;

import org.junit.jupiter.api.Test;

import java.util.Calendar;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class PersonaTest {

    @Test
    public void testPersona() {

        Calendar fechaNacimientoJuan = Calendar.getInstance();
        fechaNacimientoJuan.set(1998, Calendar.SEPTEMBER, 8);
        Calendar fechaNacimientoPepe = Calendar.getInstance();
        fechaNacimientoPepe.set(2004, Calendar.SEPTEMBER, 8);

        Persona juan = new Persona("Juan", fechaNacimientoJuan.getTime());
        Persona pepe = new Persona("Pepe", fechaNacimientoPepe.getTime());

        assertTrue(juan.esMayorQue(pepe));
        assertFalse(pepe.esMayorQue(juan));

    }

}
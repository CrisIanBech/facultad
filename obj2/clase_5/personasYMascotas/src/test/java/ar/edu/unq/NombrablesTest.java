package ar.edu.unq;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

public class NombrablesTest {
    @Test
    public void testNombrables() {
        Calendar fechaNacimientoJuan = Calendar.getInstance();
        fechaNacimientoJuan.set(1998, Calendar.SEPTEMBER, 8);
        Calendar fechaNacimientoPepe = Calendar.getInstance();
        fechaNacimientoPepe.set(2004, Calendar.SEPTEMBER, 8);

        Persona juan = new Persona("Juan", fechaNacimientoJuan.getTime());
        Persona pepe = new Persona("Pepe", fechaNacimientoPepe.getTime());

        Mascota juanMascota = new Mascota("Juan Jr.", "Pug");
        Mascota pepeMascota = new Mascota("Pepe Jr.", "Salchicha");

        Collection<Nombrable> nombrables = new ArrayList<>();
        nombrables.add(juan);
        nombrables.add(juanMascota);
        nombrables.add(pepe);
        nombrables.add(pepeMascota);
        nombrables.stream().map(Nombrable::getNombre).forEach(System.out::println);
    }
}

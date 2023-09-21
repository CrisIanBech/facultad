package ar.edu.unq;

import java.util.Calendar;
import java.util.Date;

public class Persona implements Nombrable {

    private String nombre;
    private Date fechaNacimiento;

    public Persona(String nombre, Date fechaNacimiento) {
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
    }

    @Override
    public String getNombre() {
        return nombre;
    }

    public int getEdad() {
        Calendar nacimientoFecha = Calendar.getInstance();
        nacimientoFecha.setTime(fechaNacimiento);
        Calendar ahora = Calendar.getInstance();
        ahora.setTimeInMillis(System.currentTimeMillis());
        return ahora.get(Calendar.YEAR) - nacimientoFecha.get(Calendar.YEAR);
    }

    public boolean esMayorQue(Persona persona) {
        return getEdad() > persona.getEdad();
    }

}

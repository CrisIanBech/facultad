package ar.edu.unq;

public class Mascota implements Nombrable {

    private String nombre;
    private String raza;

    public Mascota(String nombre, String raza) {
        this.nombre = nombre;
        this.raza = raza;
    }

    @Override
    public String getNombre() {
        return nombre;
    }

    public String getRaza() {
        return raza;
    }

}

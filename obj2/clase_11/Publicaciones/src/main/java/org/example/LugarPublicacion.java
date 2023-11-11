package org.example;

public class LugarPublicacion {

    private String ciudad;
    private String provincia;
    private String pais;

    public LugarPublicacion(String ciudad, String provincia, String pais) {
        this.ciudad = ciudad;
        this.provincia = provincia;
        this.pais = pais;
    }

    public String getCiudad() {
        return ciudad;
    }

    public String getProvincia() {
        return provincia;
    }

    public String getPais() {
        return pais;
    }

}

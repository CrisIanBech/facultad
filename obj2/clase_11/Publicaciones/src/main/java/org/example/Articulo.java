package org.example;

import java.util.List;

public class Articulo {

    private String titulo;
    private List<Persona> autores;
    private List<Filial> filiales;
    private TipoArticulo tipoArticulo;
    private LugarPublicacion lugarPublicacion;
    private List<String> palabrasClave;

    public Articulo(String titulo, List<Persona> autores, List<Filial> filiales, TipoArticulo tipoArticulo, LugarPublicacion lugarPublicacion, List<String> palabrasClave) {
        this.titulo = titulo;
        this.autores = autores;
        this.filiales = filiales;
        this.tipoArticulo = tipoArticulo;
        this.lugarPublicacion = lugarPublicacion;
        this.palabrasClave = palabrasClave;
    }

    public String getTitulo() {
        return titulo;
    }

    public List<Persona> getAutores() {
        return autores;
    }

    public List<Filial> getFiliales() {
        return filiales;
    }

    public TipoArticulo getTipoArticulo() {
        return tipoArticulo;
    }

    public LugarPublicacion getLugarPublicacion() {
        return lugarPublicacion;
    }

    public List<String> getPalabrasClave() {
        return palabrasClave;
    }
}

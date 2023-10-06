package org.example;

public enum ColorLesion {

    ROJO("Quemadura leve", 5),
    GRIS("Sanando", 4),
    AMARILLO("Cicatrizando", 3),
    MIEL("Sin bacterias", 2);

    private String descripcion;
    private int nivelRiesgo;

    ColorLesion(String descripcion, int nivelRiesgo) {
        this.descripcion = descripcion;
        this.nivelRiesgo = nivelRiesgo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public int getNivelRiesgo() {
        return nivelRiesgo;
    }

    public ColorLesion getSiguienteNivelMaduracion() {
        return ColorLesion.values()[(this.ordinal() + 1) % ColorLesion.values().length];
    }

}

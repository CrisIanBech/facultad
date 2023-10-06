package org.example.actividadsemanal;

public class ActividadSemanal {
    private DiaDeLaSemana dia;
    private int horaInicio;
    private int duracion;
    private Deporte deporte;

    public ActividadSemanal(DiaDeLaSemana dia, Deporte deporte,  int horaInicio, int duracion) {
        this.deporte = deporte;
        this.dia = dia;
        this.horaInicio = horaInicio;
        this.duracion = duracion;
    }

    public Deporte getDeporte() {
        return deporte;
    }

    public DiaDeLaSemana getDiaDeLaSemana() {
        return dia;
    }

    public int getHoraInicio() {
        return horaInicio;
    }

    public int getDuracion() {
        return duracion;
    }

    public double getCosto() {
        return CalculadorPreciosDeportes.getPrecioDeporteDia(deporte, dia);
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        return stringBuilder
                .append("Deporte: ").append(deporte.name())
                .append(". ")
                .append("Dia: ")
                .append(dia.name().toUpperCase())
                .append("  A LAS: ").append(getHoraInicio())
                .append(". ")
                .append("Duración: " + duracion + " hora(s).").toString();
    }

}

package org.example.actividadsemanal;

public class CalculadorPreciosDeportes {

    public static double getPrecioDeporteDia(Deporte deporte, DiaDeLaSemana dia) {
        return getPrecioPorComplejidadDeDeporte(deporte) + getPrecioPorDia(dia);
    }

    private static double getPrecioPorComplejidadDeDeporte(Deporte deporte) {
        return deporte.getComplejidad() * 200;
    }

    private static double getPrecioPorDia(DiaDeLaSemana dia) {
        double precio;
        if(dia.ordinal() < DiaDeLaSemana.JUEVES.ordinal()) {
            precio = 500;
        } else {
            precio = 1000;
        }
        return precio;
    }

}

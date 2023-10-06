package org.example.actividadsemanal;

import java.util.*;
import java.util.stream.Collectors;

public class SecretariaDeportes {

    private List<ActividadSemanal> actividadesSemanales;

    public SecretariaDeportes() {
        this.actividadesSemanales = new LinkedList<>();
    }

    public List<ActividadSemanal> actividadesDeFutbol() {
        return actividadesSemanales.stream()
                .filter(actividad -> actividad.getDeporte() == Deporte.FUTBOL)
                .toList();
    }

    public List<ActividadSemanal> actividadesConComplejidad(int complejidad) {
        return actividadesSemanales.stream()
                .filter(actividad -> actividad.getDeporte().getComplejidad() == complejidad)
                .toList();
    }

    public double cantidadTotalHorasDeActividades() {
        return actividadesSemanales.stream()
                .mapToDouble(ActividadSemanal::getDuracion)
                .sum();
    }

    public void imprimirActividades() {
        actividadesSemanales.forEach(actividadSemanal -> System.out.println(actividadSemanal.toString()));
    }

    public ActividadSemanal actividadConMenorCostoDeDeporte(Deporte deporte) {
        return actividadesSemanales.stream()
                .filter(actividadSemanal -> actividadSemanal.getDeporte() == deporte)
                .min(Comparator.comparing(ActividadSemanal::getCosto)).get();
    }

    public Map<Deporte, Optional<ActividadSemanal>> actividadesMasEconomicas() {
        return actividadesSemanales.stream()
                .collect(Collectors.groupingBy(
                            ActividadSemanal::getDeporte,
                            Collectors.minBy(Comparator.comparing(ActividadSemanal::getCosto))
                        )
                );
    }

}

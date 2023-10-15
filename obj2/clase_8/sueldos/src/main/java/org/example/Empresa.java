package org.example;

import java.util.ArrayList;
import java.util.List;

public class Empresa {
    private List<Empleado> empleados;

    public Empresa() {
        empleados = new ArrayList<>();
    }

    public void contratar(Empleado empleado) {
        empleados.add(empleado);
    }

    public double totalSueldoAPagar() {
        return empleados.stream().mapToDouble(Empleado::sueldo).sum();
    }

}

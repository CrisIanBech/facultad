package supermercado;

import java.util.ArrayList;
import java.util.List;

public class Trabajador {

    private List<Ingreso> ingresos;

    public Trabajador() {
        ingresos = new ArrayList<>();
    }

    public void agregarIngreso(Ingreso ingreso) {
        ingresos.add(ingreso);
    }

    public double getTotalPercibido() {
        return getTotalIngresos() - getImpuestoAPagar();
    }

    private double getTotalIngresos() {
        return ingresos.stream().mapToDouble(Ingreso::getMontoPercibido).sum();
    }

    public double getMontoImponible() {
        return ingresos.stream().mapToDouble(Ingreso::getMontoImponible).sum();
    }

    public double getImpuestoAPagar() {
        return (getMontoImponible() * 2) / 100;
    }

}

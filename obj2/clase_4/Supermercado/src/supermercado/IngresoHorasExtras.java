package supermercado;

public class IngresoHorasExtras extends Ingreso {

    private int horasRealizadas;

    public IngresoHorasExtras(String mesPercepcion, String concepto, Double montoPercibido, int horasRealizadas) {
        super(mesPercepcion, concepto, montoPercibido);
        this.horasRealizadas = horasRealizadas;
    }

    @Override
    public double getMontoImponible() {
        return 0;
    }
}

package supermercado;

public class Ingreso {

    private String mesPercepcion;
    private String concepto;
    private Double montoPercibido;

    public Ingreso(String mesPercepcion, String concepto, Double montoPercibido) {
        this.mesPercepcion = mesPercepcion;
        this.concepto = concepto;
        this.montoPercibido = montoPercibido;
    }

    public double getMontoImponible() {
        return montoPercibido;
    }

    public String getMesPercepcion() {
        return mesPercepcion;
    }

    public String getConcepto() {
        return concepto;
    }

    public Double getMontoPercibido() {
        return montoPercibido;
    }
}

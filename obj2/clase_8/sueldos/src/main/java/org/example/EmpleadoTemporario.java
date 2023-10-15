package org.example;

public class EmpleadoTemporario extends Empleado {

    private static final double PAGO_POR_HORA = 5;
    private static final double PAGO_POR_HIJO = 100;
    private static final double PLUS_POR_CASADO = 100;

    private final int cantidadHijos;
    private final boolean estaCasado;

    public EmpleadoTemporario(int horasTrabajadas, int cantidadHijos, boolean estaCasado) {
        super(horasTrabajadas, PAGO_POR_HORA);
        this.cantidadHijos = cantidadHijos;
        this.estaCasado = estaCasado;
    }

    @Override
    protected double aportes() {
        return sueldoBruto() * 0.13;
    }

    @Override
    protected double plusFamiliar() {
        return cantidadHijos * PAGO_POR_HIJO + plusSiEstaCasado();
    }

    private double plusSiEstaCasado() {
        return estaCasado ? PLUS_POR_CASADO : 0;
    }

    @Override
    protected double sueldoBasico() {
        return 1000;
    }

}

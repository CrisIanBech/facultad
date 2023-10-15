package org.example;

public class EmpleadoPasante extends Empleado {
    private static final double PAGO_POR_HORA = 40;

    public EmpleadoPasante(int horasTrabajadas) {
        super(horasTrabajadas, PAGO_POR_HORA);
    }

    @Override
    protected double aportes() {
        return sueldoBruto() * 0.13;
    }

    @Override
    protected double plusFamiliar() {
        return 0;
    }

    @Override
    protected double sueldoBasico() {
        return 0;
    }
}

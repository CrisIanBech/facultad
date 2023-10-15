package org.example;

public class EmpleadoPlanta extends Empleado {

    private static final double SUELDO_BASICO = 3000;
    private static final double PLUS_POR_HIJOS = 150;

    private int cantidadHijos;

    public EmpleadoPlanta(int cantidadHijos) {
        super(0, 0);
        this.cantidadHijos = cantidadHijos;
    }

    @Override
    protected double aportes() {
        return sueldoBruto() * 0.13;
    }

    @Override
    protected double plusFamiliar() {
        return cantidadHijos * PLUS_POR_HIJOS;
    }

    @Override
    protected double sueldoBasico() {
        return SUELDO_BASICO;
    }
}

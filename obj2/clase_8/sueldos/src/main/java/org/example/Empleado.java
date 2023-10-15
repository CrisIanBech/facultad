package org.example;

public abstract class Empleado {

    private int horasTrabajadas;
    private double pagoPorHora;

    public Empleado(int horasTrabajadas, double pagoPorHora) {
        this.horasTrabajadas = horasTrabajadas;
        this.pagoPorHora = pagoPorHora;
    }

    public int getHorasTrabajadas() {
        return horasTrabajadas;
    }

    public double getPagoPorHora() {
        return pagoPorHora;
    }

    public final double sueldo() {
        return sueldoBruto() - aportes();
    }

    protected final double sueldoBruto() {
        return sueldoPorHorasTrabajadas() + sueldoBasico() + plusFamiliar();
    }

    private double sueldoPorHorasTrabajadas() {
        return horasTrabajadas * pagoPorHora;
    }

    protected abstract double aportes();

    protected abstract double plusFamiliar();

    protected abstract double sueldoBasico();

}

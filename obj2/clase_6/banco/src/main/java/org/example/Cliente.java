package org.example;

public class Cliente implements Pagable {

    public Cliente(String nombre, String direccion, int edad, double sueldoMensual) {
        this.nombre = nombre;
        this.direccion = direccion;
        this.edad = edad;
        this.sueldoMensual = sueldoMensual;
    }

    private double dineroDisponible = 0;
    private String nombre;
    private String direccion;
    private int edad;
    private double sueldoMensual;

    public String getNombre() {
        return nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public int getEdad() {
        return edad;
    }

    public double getSueldoMensual() {
        return sueldoMensual;
    }

    public double getSueldoNetoAnual() {
        return getSueldoMensual() * 12;
    }

    @Override
    public void recibirPago(double monto) {
        dineroDisponible += monto;
    }
}

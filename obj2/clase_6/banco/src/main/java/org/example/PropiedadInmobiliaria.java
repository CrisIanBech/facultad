package org.example;

public class PropiedadInmobiliaria implements Garantia {

    private String descripcion;
    private String direccion;
    private double valorFiscal;

    public PropiedadInmobiliaria(String descripcion, String direccion, double valorFiscal) {
        this.descripcion = descripcion;
        this.direccion = direccion;
        this.valorFiscal = valorFiscal;
    }

    @Override
    public String getDescripcion() {
        return descripcion;
    }

    @Override
    public String getDireccion() {
        return direccion;
    }

    @Override
    public double getValorFiscal() {
        return valorFiscal;
    }
}

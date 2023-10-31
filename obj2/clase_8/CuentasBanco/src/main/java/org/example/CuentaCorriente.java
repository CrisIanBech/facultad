package org.example;
public class CuentaCorriente extends CuentaBancaria {
    private int descubierto;

    public CuentaCorriente(String titular, int descubierto) {
        super(titular);
        this.descubierto = descubierto;
    }


    @Override
    protected void informarExtraccion(int monto) {
        agregarMovimientos("Extraccion");
    }

    @Override
    protected boolean puedeExtraer(int monto) {
        return getSaldo() - monto >= getDescubierto();
    }

    public int getDescubierto() {
        return this.descubierto;
    }
}
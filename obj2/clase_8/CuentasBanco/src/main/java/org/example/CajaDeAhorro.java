package org.example;

public class CajaDeAhorro extends CuentaBancaria {
    private int limite;
    public CajaDeAhorro(String titular, int limite){
        super(titular);
        this.limite=limite;
    }
    public int getLimite(){
        return this.limite;
    }

    @Override
    protected boolean puedeExtraer(int monto) {
        return !superaLimiteDeExtraccion(monto) && tieneSaldoParaExtraer(monto);
    }

    @Override
    protected void informarExtraccion(int monto) {
        agregarMovimientos("Extraccion");
    }

    private boolean tieneSaldoParaExtraer(int monto) {
        return getSaldo() - monto >= 0;
    }

    private boolean superaLimiteDeExtraccion(int monto) {
        return monto <= getLimite();
    }
}
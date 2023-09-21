package ar.edu.unq.po2;

class Producto {

    private int stock = 0;
    private double precioBase;
    private String nombre;

    public Producto(int stock, double precioBase, String nombre) {
        this.stock = stock;
        this.precioBase = precioBase;
        this.nombre = nombre;
    }

    public void decrementarStockEn(int quantity) {
        this.stock -= quantity;
    }

    public void decrementarStock() {
        this.stock--;
    }

    public void setStock(int quantity) {
        this.stock = quantity;
    }

    public int getStock() {
        return stock;
    }

    public String getNombre() {
        return nombre;
    }

    public double getPrecio() {
        return precioBase;
    }

}

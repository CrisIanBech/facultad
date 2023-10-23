package org.example;

public class SpecialProduct extends Product {
    public SpecialProduct(float price, String name) {
        super(price, name);
    }

    @Override
    public float getPrice() {
        return super.getPrice() * 10;
    }
}

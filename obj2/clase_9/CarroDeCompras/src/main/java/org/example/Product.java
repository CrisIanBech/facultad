package org.example;

public class Product {
    private float price;
    private String name;

    public Product(float price, String name) {
        this.price = price;
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public String getName() {
        return name;
    }
}

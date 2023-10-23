package org.example;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class CarroDeCompras {

    private List<Product> products;

    public CarroDeCompras() {
        this.products = new ArrayList<>();
    }

    public List<Product> getElements() {
        return products;
    }

    public int totalRounded() {
        return (int) total();
    }

    public float total() {
        return (float) products.stream().mapToDouble(Product::getPrice).sum();
    }

    private void setElements(List<Product> newProducts) {
       products.addAll(newProducts);
    }

}

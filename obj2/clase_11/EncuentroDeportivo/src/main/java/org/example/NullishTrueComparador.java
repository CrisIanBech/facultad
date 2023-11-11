package org.example;

public class NullishTrueComparador<T> extends Comparador<T> {
    @Override
    boolean equals(T primerValor, T segundoValor) {
        return true;
    }
}

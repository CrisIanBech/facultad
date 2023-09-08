package ar.edu.unq.po2.tp3;

import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Predicate;

public class Counter {

    private final ArrayList<Integer> numbers = new ArrayList<>();

    public void addNumber(Integer number) {
        numbers.add(number);
    }

    private int occurrences(Predicate<? super Integer> predicate) {
        AtomicReference<Integer> occurrences = new AtomicReference<>(0);
        numbers.forEach(number -> {
            if(predicate.test(number)) occurrences.getAndSet(occurrences.get() + 1);
        });
        return occurrences.get();
    }

    public int getOddOcurrences() {
       return occurrences(number -> number % 2 != 0);
    }

    public int getEvenOcurrences() {
        return occurrences(numbers -> numbers % 2 == 0);
    }

    public int getMultiplesOcurrences(Integer number) {
        return occurrences(n -> n % number == 0);
    }

}

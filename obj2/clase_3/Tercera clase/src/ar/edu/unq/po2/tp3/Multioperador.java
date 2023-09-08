package ar.edu.unq.po2.tp3;

import java.util.ArrayList;

public class Multioperador {

    private ArrayList<Integer> numbers;

    public Multioperador(ArrayList<Integer> numbers) {
        this.numbers = numbers;
    }

    public Integer sumAll() {
        return numbers.stream().reduce(0, Integer::sum);
    }

    public Integer subAll() {
        return numbers.stream().reduce(0, (number, accumulation) -> accumulation - number);
    }

    public Integer multiplyAll() {
        return numbers.stream().reduce(1, (number, accumulation) -> number * accumulation);
    }

}

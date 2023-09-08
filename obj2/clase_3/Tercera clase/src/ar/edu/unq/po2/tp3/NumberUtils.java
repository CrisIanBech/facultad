package ar.edu.unq.po2.tp3;

import java.util.ArrayList;

public class NumberUtils {

    /**
     * @param numbers: should have at least one number
     * @return the number with more even digits
     */
    static Integer numberWithMoreEvenNumbers(ArrayList<Integer> numbers) {

        Integer numberWithMoreEvens = evenNumbersQuantity(numbers.get(0));
        for(int i = 1; i < numbers.size(); i++) {
            Integer actualNumber = numbers.get(i);
            Integer actualNumberEvenOccurrences = evenNumbersQuantity(numbers.get(i));
            if(actualNumberEvenOccurrences > evenNumbersQuantity(numberWithMoreEvens)) numberWithMoreEvens = actualNumber;
        }
        return numberWithMoreEvens;

    }

    private static Integer evenNumbersQuantity(Integer number) {
        Integer evenQuantity = 0;
        while(number > 0) {
            Integer digit = number % 10;
            if(digit % 2 == 0) evenQuantity++;
            number /= 10;
        }
        return evenQuantity;
    }

    static Integer higherMultipleFrom0To1000(Integer firstNumber, Integer secondNumber) {
        Integer multiple = 1000;
        while((multiple % firstNumber != 0 && multiple % secondNumber != 0) || multiple > -1) {
            multiple--;
        }
        return multiple;
    }

}

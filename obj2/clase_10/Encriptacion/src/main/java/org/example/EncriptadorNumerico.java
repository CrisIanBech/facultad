package org.example;

import java.util.Arrays;
import java.util.stream.Collectors;

public class EncriptadorNumerico implements EncripterStrategy {
    @Override
    public String encriptar(String texto) {
        String textInLowercase = texto.toLowerCase();
        return textInLowercase.chars()
                .map(charNumber -> charNumber - 96)
                .mapToObj(Integer::toString)
                .collect(Collectors.joining(","));
    }

    @Override
    public String desencriptar(String texto) {
        String[] splitString = texto.split(",");
        return Arrays.stream(splitString)
                .mapToInt(Integer::valueOf)
                .map(code -> (char) code + 96)
                .mapToObj(Character::toString)
                .collect(Collectors.joining(""));
    }
}

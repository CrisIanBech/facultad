package org.example;

import java.util.*;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class PokerStatus {

    public static Jugada verificar(
            Carta primeraCarta, Carta segundaCarta, Carta terceraCarta, Carta cuartaCarta, Carta quintaCarta
    ) {
        List<Carta> cards = new ArrayList<>();

        cards.add(primeraCarta);
        cards.add(segundaCarta);
        cards.add(terceraCarta);
        cards.add(cuartaCarta);
        cards.add(quintaCarta);

        Combinacion combinacion;

        if (areColor(cards)) {
            combinacion = Combinacion.Color;
        } else if (arePoker(cards)) {
            combinacion = Combinacion.Poquer;
        } else if (areTrio(cards)) {
            combinacion = Combinacion.Trio;
        } else {
            combinacion = Combinacion.Nada;
        }

        return new Jugada(combinacion, primeraCarta, segundaCarta, terceraCarta, cuartaCarta, quintaCarta);

    }

    private static Map<String, Long> countRepetitions(List<Carta> cards, Function<Carta, String> map) {
        return cards.stream().collect(Collectors.groupingBy(map, Collectors.counting()));
    }

    private static boolean arePoker(List<Carta> cards) {
        Function<Carta, String> mapToPaloDeCarta = carta -> carta.getPalo().name();
        Predicate<Long> predicate = repetitions -> repetitions >= 4;
        return anyMappedCountingCardsArchivesCondition(cards, mapToPaloDeCarta, predicate);
    }

    private static boolean areColor(List<Carta> cards) {
        Function<Carta, String> mapToColorYPaloDeCarta = carta -> carta.getColor().toString();
        Predicate<Long> predicate = repetitions -> repetitions == 5;
        return anyMappedCountingCardsArchivesCondition(cards, mapToColorYPaloDeCarta, predicate);
    }

    private static boolean areTrio(List<Carta> cards) {
        Function<Carta, String> mapToNumero = carta -> carta.getValor().name();
        Predicate<Long> predicate = repetitions -> repetitions == 3;
        return anyMappedCountingCardsArchivesCondition(cards, mapToNumero, predicate);
    }

    private static boolean anyMappedCountingCardsArchivesCondition(List<Carta> cards, Function<Carta, String> map, Predicate<Long> predicate) {
        Map<String, Long> repetitionsPerPalo = countRepetitions(cards, map);
        return repetitionsPerPalo.values().stream().anyMatch(predicate);
    }

}

package org.example;

public class MismaLetraInicialFilter extends WikipediaFilter {
    @Override
    protected boolean arePagesSimilar(WikipediaPage firstPage, WikipediaPage secondPage) {
        Character firstLetter = firstPage.getTitle().charAt(0);
        Character secondLetter = secondPage.getTitle().charAt(0);
        return firstLetter.equals(secondLetter);
    }
}

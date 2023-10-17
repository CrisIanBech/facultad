package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class MismaLetraInicialFilterTest {

    private WikipediaPage firstPage;
    private WikipediaPage secondPage;
    private MismaLetraInicialFilter filter;

    @BeforeEach
    public void setup() {
        firstPage = mock(WikipediaPage.class);
        secondPage = mock(WikipediaPage.class);
        filter = new MismaLetraInicialFilter();
    }

    @Test
    public void testHaveSameInitialLetter() {
        when(firstPage.getTitle()).thenReturn("Los perros");
        when(secondPage.getTitle()).thenReturn("Los gatos");

        assertTrue(filter.arePagesSimilar(firstPage, secondPage));
    }

    @Test
    public void testDontHaveSameInitialLetter() {
        when(firstPage.getTitle()).thenReturn("Perros");
        when(secondPage.getTitle()).thenReturn("Gatos");

        assertFalse(filter.arePagesSimilar(firstPage, secondPage));
    }

}
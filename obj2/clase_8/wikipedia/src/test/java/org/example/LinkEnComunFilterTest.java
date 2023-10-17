package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class LinkEnComunFilterTest {

    private WikipediaPage firstPage;
    private WikipediaPage secondPage;
    private LinkEnComunFilter filter;
    private WikipediaPage firstLink;
    private WikipediaPage secondLink;
    private WikipediaPage thirdLink;
    private WikipediaPage fourthLink;
    private List<WikipediaPage> firstPageLinks;
    private List<WikipediaPage> secondPageLinks;


    @BeforeEach
    public void setup() {
        firstPage = mock(WikipediaPage.class);
        secondPage = mock(WikipediaPage.class);
        filter = new LinkEnComunFilter();
        firstLink = mock(WikipediaPage.class);
        secondLink = mock(WikipediaPage.class);
        thirdLink = mock(WikipediaPage.class);
        fourthLink = mock(WikipediaPage.class);

        firstPageLinks = new ArrayList<>();
        secondPageLinks = new ArrayList<>();

        firstPageLinks.add(secondLink);
        firstPageLinks.add(firstLink);

        secondPageLinks.add(thirdLink);
        secondPageLinks.add(fourthLink);

        when(firstPage.getLinks()).thenReturn(firstPageLinks);
        when(secondPage.getLinks()).thenReturn(secondPageLinks);
    }

    @Test
    public void testHaveLinkInCommon() {
        when(firstLink.getTitle()).thenReturn("Los gatos");
        when(secondLink.getTitle()).thenReturn("Perros");
        when(thirdLink.getTitle()).thenReturn("Italia");
        when(fourthLink.getTitle()).thenReturn("Los gatos");

        assertTrue(filter.arePagesSimilar(firstPage, secondPage));
    }

    @Test
    public void testDontHaveLinkInCommon() {
        when(firstLink.getTitle()).thenReturn("Los gatos");
        when(secondLink.getTitle()).thenReturn("Perros");
        when(thirdLink.getTitle()).thenReturn("Italia");
        when(fourthLink.getTitle()).thenReturn("Flores");

        assertFalse(filter.arePagesSimilar(firstPage, secondPage));
    }

    @Test
    public void testEmptyLinks() {
        WikipediaPage firstPage = mock(WikipediaPage.class);
        WikipediaPage secondPage = mock(WikipediaPage.class);

        when(firstPage.getLinks()).thenReturn(new ArrayList<>());
        when(secondPage.getLinks()).thenReturn(new ArrayList<>());

        assertFalse(filter.arePagesSimilar(firstPage, secondPage));
    }

}
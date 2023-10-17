package org.example;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class PropiedadEnComunFilterTest {

    private WikipediaPage firstPage;
    private WikipediaPage secondPage;
    private PropiedadEnComunFilter filter;
    private Map<String, WikipediaPage> firstPageAttributes;
    private Map<String, WikipediaPage> secondPageAttributes;

    @BeforeEach
    public void setup() {
        firstPage = mock(WikipediaPage.class);
        secondPage = mock(WikipediaPage.class);
        filter = new PropiedadEnComunFilter();

        firstPageAttributes = new HashMap<>();
        secondPageAttributes = new HashMap<>();

        when(firstPage.getInfobox()).thenReturn(firstPageAttributes);
        when(secondPage.getInfobox()).thenReturn(secondPageAttributes);
    }

    @Test
    public void testHaveAttributeInCommon() {
        firstPageAttributes.put("birth_place", mock(WikipediaPage.class));
        firstPageAttributes.put("author_name", mock(WikipediaPage.class));

        secondPageAttributes.put("nationality", mock(WikipediaPage.class));
        secondPageAttributes.put("birth_place", mock(WikipediaPage.class));

        assertTrue(filter.arePagesSimilar(firstPage, secondPage));
    }

    @Test
    public void testDontHaveAttributeInCommon() {
        firstPageAttributes.put("birth_place", mock(WikipediaPage.class));
        firstPageAttributes.put("author_name", mock(WikipediaPage.class));

        secondPageAttributes.put("nationality", mock(WikipediaPage.class));
        secondPageAttributes.put("family", mock(WikipediaPage.class));

        assertFalse(filter.arePagesSimilar(firstPage, secondPage));
    }

    @Test
    public void testEmptyAttributes() {
        secondPageAttributes.put("nationality", mock(WikipediaPage.class));
        secondPageAttributes.put("family", mock(WikipediaPage.class));

        assertFalse(filter.arePagesSimilar(firstPage, secondPage));
    }

}
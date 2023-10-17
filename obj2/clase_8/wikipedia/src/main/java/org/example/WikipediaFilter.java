package org.example;

import java.util.List;

public abstract class WikipediaFilter {
    public final List<WikipediaPage> getSimilarPages(WikipediaPage page, List<WikipediaPage> wikipedia) {
        return wikipedia.stream().filter(pageToFilter -> arePagesSimilar(page, pageToFilter)).toList();
    }

    abstract protected boolean arePagesSimilar(WikipediaPage firstPage, WikipediaPage secondPage);
}

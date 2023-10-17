package org.example;

import java.util.List;
import java.util.stream.Stream;

public class LinkEnComunFilter extends WikipediaFilter {
    @Override
    protected boolean arePagesSimilar(WikipediaPage firstPage, WikipediaPage secondPage) {
        Stream<WikipediaPage> linksFromFirstPageStream = firstPage.getLinks().stream();
        List<WikipediaPage> linksFromSecondPage = secondPage.getLinks().stream().toList();

        return linksFromFirstPageStream.anyMatch(link -> hasLinkInCommon(linksFromSecondPage, link));
    }

    private boolean hasLinkInCommon(List<WikipediaPage> linksToLook, WikipediaPage linkToFind) {
        return linksToLook.stream().anyMatch(link -> link.getTitle().equals(linkToFind.getTitle()));
    }
}

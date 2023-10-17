package org.example;

import java.util.List;

public class PropiedadEnComunFilter extends WikipediaFilter {
    @Override
    protected boolean arePagesSimilar(WikipediaPage firstPage, WikipediaPage secondPage) {
        List<String> secondPageAttributesNames = secondPage.getInfobox().keySet().stream().toList();

        return firstPage.getInfobox().keySet().stream()
                .anyMatch(attributeName -> hasAttributeNameInCommon(secondPageAttributesNames, attributeName));
    }

    private boolean hasAttributeNameInCommon(List<String> attributes, String attributeToLook) {
        return attributes.stream().anyMatch(attributeToLook::equals);
    }
}

package org.example;

import java.util.Enumeration;
import java.util.Iterator;

public class IteratorAdapter<E> implements Enumeration<E> {
    Iterator<E> iteratorAdaptee;

    public IteratorAdapter(Iterator<E> iteratorAdaptee) {
        this.iteratorAdaptee = iteratorAdaptee;
    }

    @Override
    public boolean hasMoreElements() {
        return iteratorAdaptee.hasNext();
    }

    @Override
    public E nextElement() {
        return iteratorAdaptee.next();
    }

    @Override
    public Iterator<E> asIterator() {
        return iteratorAdaptee;
    }
}

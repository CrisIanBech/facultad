package org.example;

import javax.swing.*;
import java.util.Collection;
import java.util.Enumeration;

public class ListaDePalabrasOrdenadasAdapter extends DefaultListModel<String> {

    private ListaDePalabrasOrdenadas listaDePalabrasOrdenadas;

    public ListaDePalabrasOrdenadasAdapter(ListaDePalabrasOrdenadas listaDePalabrasOrdenadas) {
        this.listaDePalabrasOrdenadas = listaDePalabrasOrdenadas;
    }

    @Override
    public int getSize() {
        return listaDePalabrasOrdenadas.cantidadDePalabras();
    }

    @Override
    public String getElementAt(int index) {
        return listaDePalabrasOrdenadas.getPalabraDePosicion(index);
    }

    @Override
    public void copyInto(Object[] anArray) {
        for(int i = 0; i < listaDePalabrasOrdenadas.cantidadDePalabras(); i++) {
            anArray[i] = listaDePalabrasOrdenadas.getPalabraDePosicion(i);
        }
    }

    @Override
    public void trimToSize() {
        super.trimToSize();
    }

    @Override
    public void ensureCapacity(int minCapacity) {
        super.ensureCapacity(minCapacity);
    }

    @Override
    public void setSize(int newSize) {
        super.setSize(newSize);
    }

    @Override
    public int capacity() {
        return super.capacity();
    }

    @Override
    public int size() {
        return super.size();
    }

    @Override
    public boolean isEmpty() {
        return super.isEmpty();
    }

    @Override
    public Enumeration<String> elements() {
        return super.elements();
    }

    @Override
    public boolean contains(Object elem) {
        return super.contains(elem);
    }

    @Override
    public int indexOf(Object elem) {
        return super.indexOf(elem);
    }

    @Override
    public int indexOf(Object elem, int index) {
        return super.indexOf(elem, index);
    }

    @Override
    public int lastIndexOf(Object elem) {
        return super.lastIndexOf(elem);
    }

    @Override
    public int lastIndexOf(Object elem, int index) {
        return super.lastIndexOf(elem, index);
    }

    @Override
    public String elementAt(int index) {
        return super.elementAt(index);
    }

    @Override
    public String firstElement() {
        return super.firstElement();
    }

    @Override
    public String lastElement() {
        return super.lastElement();
    }

    @Override
    public void setElementAt(String element, int index) {
        super.setElementAt(element, index);
    }

    @Override
    public void removeElementAt(int index) {
        super.removeElementAt(index);
    }

    @Override
    public void insertElementAt(String element, int index) {
        super.insertElementAt(element, index);
    }

    @Override
    public void addElement(String element) {
        super.addElement(element);
    }

    @Override
    public boolean removeElement(Object obj) {
        return super.removeElement(obj);
    }

    @Override
    public void removeAllElements() {
        super.removeAllElements();
    }

    @Override
    public String toString() {
        return super.toString();
    }

    @Override
    public Object[] toArray() {
        return super.toArray();
    }

    @Override
    public String get(int index) {
        return super.get(index);
    }

    @Override
    public String set(int index, String element) {
        return super.set(index, element);
    }

    @Override
    public void add(int index, String element) {
        super.add(index, element);
    }

    @Override
    public String remove(int index) {
        return super.remove(index);
    }

    @Override
    public void clear() {
        super.clear();
    }

    @Override
    public void removeRange(int fromIndex, int toIndex) {
        super.removeRange(fromIndex, toIndex);
    }

    @Override
    public void addAll(Collection<? extends String> c) {
        super.addAll(c);
    }

    @Override
    public void addAll(int index, Collection<? extends String> c) {
        super.addAll(index, c);
    }
}

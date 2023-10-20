package org.example;

public interface FileSystem {
    /**
     * Retorna el total ocupado en disco del receptor. Expresado en
     *cantidad de bytes.
     */
    int totalSize();
    /**
     * Imprime en consola el contenido indicando el nombre del elemento
     Programación Orientada a Objetos II
     * e indentandolo con tantos espacios como profundidad en la
     estructura.
     */
    void printStructure(String identation);
    /**
     * Elemento mas nuevo
     */
    File lastModified();
    /** Elemento mas antiguo
     */
    File oldestElement();
}

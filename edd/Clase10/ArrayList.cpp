#include "ArrayList.h"
#include <iostream>
using namespace std;

ArrayList newArrayList(){
    ArrayListSt* newArrayL = new ArrayListSt;
    int* elementos = new int[16];
    newArrayL->capacidad = 16; newArrayL->cantidad = 0;
    newArrayL->elementos = elementos;
    return newArrayL;
} 
// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16.
ArrayList newArrayListWith(int capacidad){
    ArrayListSt* newArrayL = new ArrayListSt;
    int* elementos = new int[capacidad];
    newArrayL->capacidad = capacidad; newArrayL->cantidad = 0;
    newArrayL->elementos = elementos;
    return newArrayL;
}
// Crea una lista con 0 elementos y una capacidad dada por parámetro.
int lengthAL(ArrayList xs){
    return xs->cantidad;
}
// Devuelve la cantidad de elementos existentes.
int get(int i, ArrayList xs){
    return xs->elementos[i];
}
// Devuelve el iésimo elemento de la lista.
void set(int i, int x, ArrayList xs){
    xs->elementos[i] = x;
}
// Reemplaza el iésimo elemento por otro dado.
void resize(int capacidad, ArrayList xs){
    int* nuevosElems = new int[capacidad];
    for(int i = 0; i < capacidad && i < xs->cantidad; i++){
        nuevosElems[i] = xs->elementos[i];
    }
    delete xs->elementos;
    xs->capacidad = capacidad;
    xs->cantidad = (xs->cantidad <= capacidad) ? xs->cantidad : capacidad;
    xs->elementos = nuevosElems;
}
// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.

void add(int x, ArrayList xs){
    if(xs->cantidad == xs->capacidad){
        resize(xs->capacidad * 2, xs);
        xs->capacidad = xs->capacidad * 2;
    }
    xs->elementos[xs->cantidad] = x;
    xs->cantidad++;
}

// Agrega un elemento al final de la lista. 
// Precond: El ArrayList debe de tener al menos 1 de capacidad.

void remove(ArrayList xs){
    xs->cantidad--;
}
// Borra el último elemento de la lista.
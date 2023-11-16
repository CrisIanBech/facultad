#include "LinkedList.h"
#include <stdio.h>
#include <iostream>
using namespace std;

LinkedList nil(){
    LinkedListSt* newLL = new LinkedListSt;
    newLL->cantidad = 0;
    newLL->primero = NULL;
    newLL->ultimo = NULL;
    return newLL;
};
// Crea una lista vacía.

bool isEmpty(LinkedList xs){
    return xs->cantidad = 0;
}
// Indica si la lista está vacía.

int head(LinkedList xs){
    return xs->primero->elem;
}
// Devuelve el primer elemento.

void Cons(int x, LinkedList xs){
    NodoLL* newNodo = new NodoLL;
    newNodo->elem = x;
    newNodo->siguiente = xs->primero;
    xs->primero = newNodo;
    if(xs->cantidad == 0){
        xs->ultimo = newNodo;
    }
    xs->cantidad++;
}
// Agrega un elemento al principio de la lista.

void Tail(LinkedList xs){
    NodoLL* newNodo = xs->primero;
    xs->primero = xs->primero->siguiente;
    if(xs->cantidad == 1){
        xs->ultimo == NULL;
    }
    xs->cantidad--;
    delete newNodo;
}
// Quita el primer elemento.
// PRECON: Debe de tener al menos un elemento.

int length(LinkedList xs){
    return xs->cantidad;
}
// Devuelve la cantidad de elementos.

void Snoc(int x, LinkedList xs){
    NodoLL* newNodo = new NodoLL;
    newNodo->elem = x;
    newNodo->siguiente = NULL;
    if(xs->cantidad == 0){
        xs->primero = newNodo;
    }else{
        xs->ultimo->siguiente = newNodo;
    }
    xs->ultimo = newNodo;
    xs->cantidad++;
}
// Agrega un elemento al final de la lista.

ListIterator getIterator(LinkedList xs){
    IteratorSt* newITLL = new IteratorSt;
    newITLL->current = xs->primero;
    return newITLL;
}
// Apunta el recorrido al primer elemento.IteratorSt*

int current(ListIterator ixs){
    return ixs->current->elem;
}
// Devuelve el elemento actual en el recorrido.

void SetCurrent(int x, ListIterator ixs){
    ixs->current->elem = x;
}
// Reemplaza el elemento actual por otro elemento.

void Next(ListIterator ixs){
    ixs->current = ixs->current->siguiente;
}
// Pasa al siguiente elemento.

bool atEnd(ListIterator ixs){
    return ixs->current == NULL;
}
// Indica si el recorrido ha terminado.

void DisposeIterator(ListIterator ixs){
    delete ixs;
}
// Libera la memoria ocupada por el iterador.

void DestroyL(LinkedList xs){
    if(xs->cantidad != 0){
        NodoLL* current = xs->primero;
        NodoLL* nextN;
        while(current != NULL){
            nextN = current->siguiente;
            delete current;
            current = nextN;
        }
    }
    delete xs;
}
// Libera la memoria ocupada por la lista.

void Append(LinkedList xs, LinkedList ys){
    xs->ultimo->siguiente = ys->primero;
    if(ys->cantidad > 0){
        xs->ultimo = ys->ultimo;
    }
    delete ys;
}
// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
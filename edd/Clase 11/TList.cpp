#include "TList.h"
#include <stdio.h>
#include <iostream>
using namespace std;

TList nilTL(){
    TListSt* newLL = new TListSt;
    newLL->cantidad = 0;
    newLL->primero = NULL;
    newLL->ultimo = NULL;
    return newLL;
};
// Crea una lista vacía.

bool isEmptyTL(TList xs){
    return xs->cantidad = 0;
}
// Indica si la lista está vacía.

Tree headTL(TList xs){
    return xs->primero->elem;
}
// Devuelve el primer elemento.

void ConsTL(Tree x, TList xs){
    NodoL* newNodo = new NodoL;
    newNodo->elem = x;
    newNodo->siguiente = xs->primero;
    xs->primero = newNodo;
    if(xs->cantidad == 0){
        xs->ultimo = newNodo;
    }
    xs->cantidad++;
}
// Agrega un elemento al principio de la lista.

void TailTL(TList xs){
    NodoL* newNodo = xs->primero;
    xs->primero = xs->primero->siguiente;
    if(xs->cantidad == 1){
        xs->ultimo == NULL;
    }
    xs->cantidad--;
    delete newNodo;
}
// Quita el primer elemento.
// PRECON: Debe de tener al menos un elemento.

int lengthTL(TList xs){
    return xs->cantidad;
}
// Devuelve la cantidad de elementos.

void SnocTL(Tree x, TList xs){
    NodoL* newNodo = new NodoL;
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

TLIterator getIteratorTLI(TList xs){
    TLIteratorSt* newITLL = new TLIteratorSt;
    newITLL->current = xs->primero;
    return newITLL;
}
// Apunta el recorrido al primer elemento.TLIteratorSt*

Tree currentTLI(TLIterator ixs){
    return ixs->current->elem;
}
// Devuelve el elemento actual en el recorrido.

void SetCurrentTLI(Tree x, TLIterator ixs){
    ixs->current->elem = x;
}
// Reemplaza el elemento actual por otro elemento.

void NextTLI(TLIterator ixs){
    ixs->current = ixs->current->siguiente;
}
// Pasa al siguiente elemento.

bool atEndTLI(TLIterator ixs){
    return ixs->current == NULL;
}
// Indica si el recorrido ha terminado.

void DisposeIteratorTLI(TLIterator ixs){
    delete ixs;
}
// Libera la memoria ocupada por el iterador.

void DestroyTL(TList xs){
    if(xs->cantidad != 0){
        NodoL* current = xs->primero;
        NodoL* nextN;
        while(current != NULL){
            nextN = current->siguiente;
            delete current;
            current = nextN;
        }
    }
    delete xs;
}
// Libera la memoria ocupada por la lista.

void AppendTL(TList xs, TList ys){
    xs->ultimo->siguiente = ys->primero;
    if(ys->cantidad > 0){
        xs->ultimo = ys->ultimo;
    }
    delete ys;
}
// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
// Nota: notar que el costo mejoraría si SnocT fuese O(1), ¿cómo podría serlo?
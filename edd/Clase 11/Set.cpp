#include "Set.h"
#include <iostream>
using namespace std;
#include <stdio.h>

Set emptyS(){
    SetSt* nuevoSet = new SetSt;
    nuevoSet->cantidad = 0;
    nuevoSet->primero = NULL;
    return nuevoSet;
}
// Crea un conjunto vacío.

bool isEmptyS(Set s){
    return s->cantidad == 0;
}
// Indica si el conjunto está vacío.

bool belongsS(int x, Set s){
    NodoS* nodoActual = s->primero;
    while(nodoActual != NULL && nodoActual->elem != x){
        nodoActual = nodoActual->siguiente;
    }
    return nodoActual != NULL;
}
// Indica si el elemento pertenece al conjunto.

void AddS(int x, Set s){
    NodoS* nuevoElemento = new NodoS;
    nuevoElemento->elem = x;
    nuevoElemento->siguiente = NULL;
    if(s->primero == NULL){
        s->primero = nuevoElemento;
        s->cantidad++;
    }else{
        NodoS* nodoActual = s->primero;
        if(nodoActual->elem != x){
            while(nodoActual->siguiente != NULL && nodoActual->siguiente->elem != x){
                nodoActual = nodoActual->siguiente;
            }
            if(nodoActual->siguiente == NULL){
                s->cantidad++;
                nodoActual->siguiente = nuevoElemento;
            }else{
                delete nuevoElemento;
            }
        }
    }
}
// Agrega un elemento al conjunto.

void RemoveS(int x, Set s){
    NodoS* nodoActual = s->primero;
    if(nodoActual != NULL && nodoActual->elem == x){
        delete s->primero;
        s->primero = NULL;
        s->cantidad--;
    }else if(nodoActual != NULL){
        while(nodoActual->siguiente != NULL && nodoActual->siguiente->elem != x){
            nodoActual = nodoActual->siguiente;
            cout << "X";
        }
        if(nodoActual->siguiente != NULL){
            NodoS* nodoABorrar = nodoActual->siguiente;
            nodoActual->siguiente = nodoActual->siguiente->siguiente;
            delete nodoABorrar;
            s->cantidad--;
        }
    }
}
// Quita un elemento dado si lo posee.

int sizeS(Set s){
    return s->cantidad;
}
// Devuelve la cantidad de elementos.
LinkedList setToList(Set s){
    NodoS* nodoActual = s->primero;
    LinkedList nuevaLista = nil();
    while(nodoActual != NULL){
        Snoc(nodoActual->elem, nuevaLista);
        nodoActual = nodoActual->siguiente;
    }
    return nuevaLista;
}
// Devuelve una lista con los lementos del conjunto.

void DestroyS(Set s){
    NodoS* nodoActual = s->primero;
    NodoS* siguienteNodo;
    while(nodoActual != NULL){
        siguienteNodo = nodoActual->siguiente;
        delete nodoActual;
        nodoActual = siguienteNodo;
    }
    delete s;
}
// Libera la memoria ocupada por el conjunto.

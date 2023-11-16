#include "Queue.h"
#include "iostream"

Queue emptyQ(){
    QueueSt* nuevoQ = new QueueSt;
    nuevoQ->cantidad = 0;
    nuevoQ->primero = NULL;
    nuevoQ->ultimo = NULL;
    return nuevoQ;
}
// Crea una lista vacía.
// Costo: O(1).

bool isEmptyQ(Queue q){
    return q->cantidad == 0;
}
// Indica si la lista está vacía.
// Costo: O(1).

int firstQ(Queue q){
    return q->primero->elem;
}
// Devuelve el primer elemento.
// Costo: O(1).

void Enqueue(int x, Queue q){
    NodoQ* nuevoNodo = new NodoQ;
    nuevoNodo->elem = x;
    nuevoNodo->siguiente = NULL;
    if(q->cantidad = 0){
        q->primero = nuevoNodo;
    }else{
        q->ultimo->siguiente = nuevoNodo;
    }
    q->ultimo = nuevoNodo;
    q->cantidad++;
}
// Agrega un elemento al final de la cola.
// Costo: O(1).

void Dequeue(Queue q){
    NodoQ* nodoASacar = q->primero;
    q->primero = nodoASacar->siguiente;
    delete nodoASacar;
}
// Quita el primer elemento de la cola.
// Costo: O(1).
// Precond: La cola debe de tener al menos un elemento

int lengthQ(Queue q){
    return q->cantidad;
}
// Devuelve la cantidad de elementos de la cola.
// Costo: O(1).

void MergeQ(Queue q1, Queue q2){
    while(!isEmptyQ(q2)){
        Enqueue(firstQ(q2), q1);
    }
    delete q2;
}
// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
// Costo: O(1).

void DestroyQ(Queue q){
    while(!isEmptyQ(q)){
        Dequeue(q);
    }
    delete q;
}
// Libera la memoria ocupada por la lista.
// Costo: O(n).
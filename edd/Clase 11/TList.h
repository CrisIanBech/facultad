#include "Tree.h"

struct NodoL {
    Tree elem; // valor del nodo
    NodoL* siguiente; // puntero al siguiente nodo
};

struct TListSt {
    // INV.REP.: cantidad indica la cantidad de nodos que se pueden recorrer
    // desde primero por siguiente hasta alcanzar a NULL
    int cantidad; // cantidad de elementos
    NodoL* primero; // puntero al primer nodo
    NodoL* ultimo; // puntero al último nodo
};

struct TLIteratorSt {
    NodoL* current;
};


typedef TLIteratorSt* TLIterator; // INV.REP.: el puntero NO es NULL

typedef TListSt* TList; // INV.REP.: el puntero NO es NULL

TList nilTL();
// Crea una lista vacía.
bool isEmptyTL(TList xs);
// Indica si la lista está vacía.
Tree headTL(TList xs);
// Devuelve el primer elemento.
void ConsTL(Tree x, TList xs);
// Agrega un elemento al principio de la lista.
void TailTL(TList xs);
// Quita el primer elemento.
int lengthTL(TList xs);
// Devuelve la cantidad de elementos.
void SnocTL(Tree x, TList xs);
// Agrega un elemento al final de la lista.
TLIterator getIteratorTL(TList xs);
// Apunta el recorrido al primer elemento.
Tree currentTLI(TLIterator ixs);
// Devuelve el elemento actual en el recorrido.
void SetCurrentTLI(Tree x, TLIterator ixs);
// Reemplaza el elemento actual por otro elemento.
void NextTLI(TLIterator ixs);
// Pasa al siguiente elemento.
bool atEndTLI(TLIterator ixs);
// Indica si el recorrido ha terminado.
void DisposeIteratorTLI(TLIterator ixs);
// Libera la memoria ocupada por el iterador.
void DestroyTL(TList xs);
// Libera la memoria ocupada por la lista.
void AppendTL(TList xs, TList ys);
// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
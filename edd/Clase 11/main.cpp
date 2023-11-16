#include "LinkedList.h"
#include "Set.h"
#include "Tree.h"
#include "TList.h"
#include "../Clase10/ArrayList.h"
#include "Heap.h"
#include <iostream>
using namespace std;

void MostrarLista(LinkedList xs){
    int elemento = 0;
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador)){
        cout << "elemento " << elemento << " = " << current(iterador)  << endl;
        elemento++;
        Next(iterador);
    }
    DisposeIterator(iterador);
} 

LinkedList array2LL(int *xs){
    LinkedList listaCopia = nil();
    for(int i = 0; i < sizeof(xs) + 1; i++){
        Snoc(xs[i], listaCopia);
    }
    return listaCopia;
}

int sumatoria(LinkedList xs){
    int sumaHastaAhora = 0;
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador)){
        sumaHastaAhora += current(iterador);
        Next(iterador);
    }
    DisposeIterator(iterador);
    return sumaHastaAhora;
}
// Devuelve la suma de todos los elementos.

void Sucesores(LinkedList xs){
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador)){
        SetCurrent(current(iterador) + 1, iterador);
        Next(iterador);
    }
    DisposeIterator(iterador);
}
// Incrementa en uno todos los elementos.

bool pertenece(int x, LinkedList xs){
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador) && current(iterador) != x){
        Next(iterador);
    }
    bool aparece = !atEnd(iterador); 
    DisposeIterator(iterador);
    return aparece;
}
// Indica si el elemento pertenece a la lista.

int apariciones(int x, LinkedList xs){
    int aparicionesHastaAhora = 0;
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador)){
        if(current(iterador) == x){
            aparicionesHastaAhora++;
        }
        Next(iterador);
    }
    DisposeIterator(iterador);
    return aparicionesHastaAhora;
}
// Indica la cantidad de elementos iguales a x.

int minimo(LinkedList xs){
    ListIterator iterador = getIterator(xs);
    int minimoHastaAhora = current(iterador);
    Next(iterador);
    while(!atEnd(iterador)){
        if(current(iterador) < minimoHastaAhora){
            minimoHastaAhora = current(iterador);
        }
        Next(iterador);
    }
    DisposeIterator(iterador);
    return minimoHastaAhora;
}
// Devuelve el elemento más chico de la lista.
// Precon: La lista tiene al menos un elemento.

LinkedList copy(LinkedList xs){
    LinkedList listaCopia = nil();
    ListIterator iterador = getIterator(xs);
    while(!atEnd(iterador)){
        Snoc(current(iterador), listaCopia);
        Next(iterador);
    }
    DisposeIterator(iterador);
    return listaCopia;
}
// Dada una lista genera otra con los mismos elementos, en el mismo orden.
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?

// 
//  TREES
//

int sumarT(Tree t){
    TList faltanPorProcesar = nilTL();
    int sumaHastaAhora = 0;
    if(!isEmptyT(t)){ ConsTL(t, faltanPorProcesar); }
    while(!isEmptyTL(faltanPorProcesar)){
        Tree actual = headTL(faltanPorProcesar);
        sumaHastaAhora += rootT(actual);
        if(!isEmptyT(right(actual))){  ConsTL(right(actual), faltanPorProcesar); }
        if(!isEmptyT(left(actual))) {  ConsTL(left(actual), faltanPorProcesar);  }
        TailTL(faltanPorProcesar);
    }
    delete faltanPorProcesar;
    return sumaHastaAhora;
}

int sizeT(Tree t){
    TList faltanPorProcesar = nilTL();
    int elementosHastaAhora = 0;
    if(!isEmptyT(t)){ ConsTL(t, faltanPorProcesar); }
    while(!isEmptyTL(faltanPorProcesar)){
        Tree actual = headTL(faltanPorProcesar);
        elementosHastaAhora++;
        if(!isEmptyT(right(actual))){ ConsTL(right(actual), faltanPorProcesar); }
        if(!isEmptyT(left(actual))){ ConsTL(left(actual), faltanPorProcesar); }
        TailTL(faltanPorProcesar);
    }
    delete faltanPorProcesar;
    return elementosHastaAhora;
}
// Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
// en inglés).
// Dado un árbol binario de enteros devuelve la suma entre sus elementos.

bool perteneceT(int e, Tree t){ 
    TList faltanPorProcesar = nilTL();
    if(!isEmptyT(t)){ ConsTL(t, faltanPorProcesar); }
    while(!isEmptyTL(faltanPorProcesar) && rootT(headTL(faltanPorProcesar)) != e){
        Tree actual = headTL(faltanPorProcesar);
        if(e < rootT(actual)){
            ConsTL(left(actual), faltanPorProcesar); 
        }
        else{
            ConsTL(right(actual), faltanPorProcesar); 
        }
        TailTL(faltanPorProcesar);
    }
    delete faltanPorProcesar;
    return !isEmptyT(headTL(faltanPorProcesar));
}
// Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
// árbol.

int aparicionesT(int e, Tree t){
    TList faltanPorProcesar = nilTL();
    int aparicionesHastaAhora = 0;
    if(!isEmptyT(t)){ ConsTL(t, faltanPorProcesar); }
    while(!isEmptyTL(faltanPorProcesar)){
        Tree actual = headTL(faltanPorProcesar);
        if(rootT(actual) == e){ aparicionesHastaAhora++; }
        if(!isEmptyT(right(actual))){ ConsTL(right(actual), faltanPorProcesar); }
        if(!isEmptyT(left(actual))){ ConsTL(left(actual), faltanPorProcesar); }
        TailTL(faltanPorProcesar);
    }
    delete faltanPorProcesar;
    return aparicionesHastaAhora;
}
// Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
// iguales a e.

int mayorEntre(int x, int y){
    if(x > y){
        return x;
    }else{
        return y;
    }
}
// Devuelve el mayor número entre los dos.

int heightT(Tree t){
    if(isEmptyT(t)){
        return 0;
    }else{
        return 1 + mayorEntre(heightT(left(t)), heightT(right(t)));
    } 
}
// Dado un árbol devuelve su altura

ArrayList leaves(Tree t){
    ArrayList elementosHastaAhora = newArrayList();
    TList faltanPorProcesar = nilTL();
    if(!isEmptyT(t)){ ConsTL(t, faltanPorProcesar); }
    while(!isEmptyTL(faltanPorProcesar)){
        Tree actual = headTL(faltanPorProcesar);
        add(rootT(actual), elementosHastaAhora);
        TailTL(faltanPorProcesar);
        if(!isEmptyT(right(actual))){ ConsTL(right(actual), faltanPorProcesar); }
        if(!isEmptyT(left(actual))) { ConsTL(left(actual), faltanPorProcesar);  }
    }
    delete faltanPorProcesar;
    return elementosHastaAhora;
}
// Dado un árbol devuelve los elementos que se encuentran en sus hojas.

void LevelNRec(int n, int a, TList elementosHastaAhora, Tree t){
    if(a == n){
        ConsTL(t, elementosHastaAhora);
    }else if(n < a){
        if(!isEmptyT(right(t))){
            LevelNRec(n, a++, elementosHastaAhora, right(t));
        }
        if(!isEmptyT(left(t))){
           LevelNRec(n, a, elementosHastaAhora, left(t));
        }
    }
}
// Agrega los elementos del 

TList levelN(int n, Tree t){
    TList elementosHastaAhora = nilTL();
    LevelNRec(n, 0, elementosHastaAhora, t);    
    return elementosHastaAhora;
}
// Dados un número n y un árbol devuelve una lista con los nodos de nivel n.

int main(){
    int* arrayPrueba = new int[5];
    for(int i = 0; i < 5; i++){
        arrayPrueba[i] = i + 1;
    }
    LinkedList llPrueba = array2LL(arrayPrueba);
    // MostrarLista(llPrueba);
    // cout << endl;
    // cout << sumatoria(llPrueba) << endl;
    // Sucesores(llPrueba);
    // MostrarLista(llPrueba);
    // cout << endl << pertenece(7, llPrueba);
    // cout << apariciones(2, llPrueba);
    // cout << minimo(llPrueba);
    // LinkedList copiaLL = copy(llPrueba);
    // Append(llPrueba, copiaLL);
    // MostrarLista(llPrueba);
    int* asdfg = new int[9];
    asdfg[1] = 10;
    asdfg[2] = 50;
    asdfg[3] = 70;
    asdfg[4] = 8;

    BinHeap miHeap = crearHeap(asdfg, 4);
}
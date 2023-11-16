#include "Heap.h"
#include <iostream>
#include "limits.h"
using namespace std;

BinHeap emptyHeap(){
    BinHeapHeaderSt* nuevoHeap = new BinHeapHeaderSt;
    nuevoHeap->curSize = 0;
    nuevoHeap->maxSize = 16;
    int* elementos = new int[nuevoHeap->maxSize];
    nuevoHeap->elems = elementos;
    nuevoHeap->elems[0] = INT_MIN;
    return nuevoHeap;
}

void DoubleSizeHeap(BinHeap h){
    int* newElements = new int[h->maxSize * 2];
    for(int i = 0; i < h->maxSize; i++){
        newElements[i] = h->elems[i];
    }
    delete h->elems;
    h->elems = newElements;
    h->maxSize *= 2;
}

void InsertH(int x, BinHeap h){
    if(h->curSize == (h->maxSize - 1)){
        DoubleSizeHeap(h);
    }
    int curNode = ++h->curSize;
    while(x < h->elems[curNode / 2]){
        h->elems[curNode] = h->elems[curNode / 2]; 
        curNode /= 2;
    } 
    h->elems[curNode] = x;
}

bool isEmptyHeap(BinHeap h){
    return h->curSize == 0;
}

int findMin(BinHeap h){
    return h->elems[1];
}

void deleteMin(BinHeap h){
    int child; int curNode;
    int last = h->elems[h->curSize--];
    for(curNode = 1; curNode * 2 <= h->curSize; curNode = child){
        child = curNode * 2;
        if(child != h->curSize && h->elems[child] > h->elems[child + 1]){ child++; }
        if(last > h->elems[child]){ h->elems[curNode] = h->elems[child]; }
        else{ break; }
    }
    h->elems[curNode] = last;
}

BinHeap crearHeap(int* elements, int cant){
    cant++;
    int* newElements = new int[cant];
    newElements[0] = INT_MIN;
    for(int i = 1; i < cant; i++){
        newElements[i] = elements[i - 1];
    } 
    BinHeapHeaderSt* nuevoHeap = new BinHeapHeaderSt;
    nuevoHeap->curSize = cant;
    nuevoHeap->maxSize = cant;
    nuevoHeap->elems = newElements;

    // Floto elemento
    for(int i = (cant / 2); i <= cant; i++){
        int curNode = i;
        int last = nuevoHeap->elems[i];
        while(last < nuevoHeap->elems[curNode / 2]){
            nuevoHeap->elems[curNode] = nuevoHeap->elems[curNode / 2];
            curNode /= 2;
        }
        nuevoHeap->elems[curNode] = last;
    }

    return nuevoHeap;
}
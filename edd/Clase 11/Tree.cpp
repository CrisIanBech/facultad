#include "Tree.h"
#include <iostream>
using namespace std;

Tree emptyT(){
    return NULL;
}

Tree nodeT(int elem, Tree left, Tree right){
    NodeT* nuevoNodoT = new NodeT;
    nuevoNodoT->elem = elem;
    nuevoNodoT->left = left;
    nuevoNodoT->right = right;
    return nuevoNodoT;
}

bool isEmptyT(Tree t){
    return t == NULL;
}

int rootT(Tree t){
    return t->elem;
}

Tree left(Tree t){
    return t->left;
}

Tree right(Tree t){
    return t->right;
}
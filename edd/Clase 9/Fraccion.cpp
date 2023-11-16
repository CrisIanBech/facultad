#include "Fraccion.h"
#include <stdlib.h>

// Propósito: construye una fraccion
// Precondición: el denominador no es cero
Fraccion consFraccion(int numerador, int denominador){
    Fraccion p;
    p.numerador = numerador;
    p.denominador = denominador;
    return p;
}
// Propósito: devuelve el numerador
int numerador(Fraccion f){
    return f.numerador;
}
// Propósito: devuelve el denominador
int denominador(Fraccion f){
    return f.denominador;
}
// Propósito: devuelve el resultado de hacer la división
float division(Fraccion f){
    float r = f.denominador / f.denominador;
    return r;
}
// Propósito: devuelve una fracción que resulta de multiplicar las fracciones
// (sin simplificar)
Fraccion multF(Fraccion f1, Fraccion f2){
    Fraccion fraccionResult;
    fraccionResult.numerador = f1.numerador * f2.numerador;
    fraccionResult.denominador = f1.denominador * f2.denominador;
    return fraccionResult;
}

// Propósito: devuelve una fracción que resulta
// de simplificar la dada por parámetro
Fraccion simplificada(Fraccion p){
    int min = p.numerador < p.denominador ? p.numerador : p.denominador;
    while(min > 1){
        if(p.numerador % min == 0 && p.denominador % min == 0){
            p.numerador = p.numerador / min;
            p.denominador = p.denominador / min;
            return p;
        }
        min--;
    }
    return p;
}

// Propósito: devuelve la primera componente
Fraccion sumF(Fraccion f1, Fraccion f2){
    if(f1.denominador == f2.denominador){
        f1.numerador = f1.numerador + f2.numerador;
        return f1;
    }
    f1.denominador = f1.denominador * f2.denominador;
    f1.numerador = (f1.numerador * f1.denominador) + (f2.numerador * f1.denominador);
    return simplificada(f1);
}
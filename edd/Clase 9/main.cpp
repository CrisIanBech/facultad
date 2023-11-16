#include <iostream>
#include "Par.h"
#include <string>
#include "Fraccion.h"
using namespace std;

// Propósito: Imprime el número del código ascii de c1 a c2
// Precondición: c1 < c2
void printFromTo(char c1, char c2) {
    for(int i = 0; c1 + i <= c2; i++) {
        cout << c1 + i << ", ";
    }
    cout << endl;
}

// Propósito: Imprime el número del código ascii de **c1** a **c2**
// Precondición: c1 < c2
void printFromTo2(char c1, char c2) {
    while(c1 <= c2){
        cout << c1 + 0 << ", ";
        c1 = c1 + 1;
    }
    cout << endl;
}

// Propósito: Devuelve el factorial de **n**
// Precondición: n >= 0
int fc(int n) {
    int x = 1;
    while(n > 0) {
        x = x * n;
        n--;
    }
    return x;
}

// Propósito: Devuelve la sumatoria de los números entre **n** y **m** inclusivos.
// Precondición: n <= m
int ft(int n, int m) {
    if (n == m) {
        return n;
    }
    return n + ft(n+1, m);
}

int ft2(int n, int m) {
    int l = 0;
    while(n <= m){
        l += n;
        n++;
    }
    return l;
}


void printN(int n, string s){
// Propósito: imprime n veces un string s.
    while(n > 0){
        cout << s;
        n--;
    }
}
void cuentaRegresiva(int n){
// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
    while(n >= 0){
        cout << n << endl;
        n--;
    }
}
void desdeCeroHastaN(int n){
// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
    int x = 0;
    while(x <= n){
        cout << x << endl;
        x++;
    }
}
int mult(int n, int m){
// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
    int x = 0;
    if((n >= 0 && m < 0) || (m >= 0 && n < 0)){
        m = abs(m);
        while(m > 0){
            x += n;
            m--;
        }
        return -x;
    }
    m = abs(m);
    while(m > 0){
        x += n;
        m--;
    }
    return x;
}
void primerosN(int n, string s){
// Propósito: imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
    while(n > 0){
        cout << s[0] << endl;
        n--;
        s = s.substr(1, s.length());
    }
}
bool pertenece(char c, string s){
// Propósito: indica si un char c aparece en el string s.
    while(s.length() > 0 && c != s[0]){
        s = s.substr(1, s.length());
    }
    return s.length() > 0;
}
int apariciones(char c, string s){
// Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    int apariciones = 0;
    while(s.length() > 0){
        if(s[0] == c){
            apariciones++;
        }
        s = s.substr(1, s.length());
    }
    return apariciones;
}


int main(){
    // Par x;
    // x = consPar(1, 3);
    // cout << fst(x) << endl;
    // cout << snd(x) << endl;
    // cout << maxDelPar(x) << endl;
    // cout << fst(swap(x)) << snd(swap(x)) << endl;
    // cout << fst(divisionYResto(10, 2)) << endl << snd(divisionYResto(10, 2)) << endl;
    
    // printFromTo('a', 'z');
    // printFromTo2('a', 'z');
    // cout << ft(5, 10) << endl;
    // cout << ft2(5, 10);

    // printN(5, "Hola");
    // cuentaRegresiva(6);
    // desdeCeroHastaN(10);
    // cout << mult(5, 5) << endl;
    // primerosN(5, "12345678");
    // cout << pertenece('c', "asdfc") << endl;
    // cout << apariciones('5', "1234555") << endl;
    
    Fraccion frac;
    frac = consFraccion(10, 2);
    Fraccion frac2;
    frac2 = consFraccion(13, 3);
    Fraccion fxc;
    fxc = sumF(frac, frac2);

    cout << numerador(fxc) << endl << denominador(fxc);
    return 0;
}


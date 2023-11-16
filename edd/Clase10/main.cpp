#include "Persona.h"
using namespace std;
#include <string>
#include <iostream>
#include "Entrenador.h"
#include "ArrayList.h"

int sumatoria(ArrayList xs){
    int sumadoHastaAhora = 0;
    for(int i = 0; i < lengthAL(xs); i++){
        sumadoHastaAhora += get(i, xs);
    }
    return sumadoHastaAhora;
 }
// Devuelve la suma de todos los elementos.

void sucesores(ArrayList xs){
    for(int i = 0; i < lengthAL(xs); i++){
        set(i, (get(i, xs) + 1), xs);
    }
}
// Incrementa en uno todos los elementos.

bool pertenece(int x, ArrayList xs){
    int elementosVistos = 0;
    while(elementosVistos < lengthAL(xs) && (get(elementosVistos, xs)) != x){
        elementosVistos++;
    }
    return elementosVistos < lengthAL(xs);
}
// Indica si el elemento pertenece a la lista.

int apariciones(int x, ArrayList xs){
    int aparicionesHastaAhora = 0;
    for(int i = 0; i < lengthAL(xs); i++){
        if(get(i, xs) == x){
            aparicionesHastaAhora++;
        }
    }
    return aparicionesHastaAhora;
}
// Indica la cantidad de elementos iguales a x.

ArrayList append(ArrayList xs, ArrayList ys){
    ArrayList arrayNuevo = newArrayListWith(lengthAL(xs) + lengthAL(ys));
    for(int i = 0; i < lengthAL(xs); i++){
        add(get(i, xs), arrayNuevo);
    }
    for(int i = 0; i < lengthAL(ys); i++){
        add(get(i, ys), arrayNuevo);
    }
    return arrayNuevo;
}
// Crea una nueva lista a partir de la primera y la segunda (en ese orden).

int minimo(ArrayList xs){
    int minimoHastaAhora = get(0, xs); 
    for(int i = 1; i < lengthAL(xs); i++){
        if(get(i, xs) < minimoHastaAhora){
            minimoHastaAhora = get(i, xs);
        }
    }
    return minimoHastaAhora;
}
// Devuelve el elemento más chico de la lista.
// Precon: La lista debe de tener al menos un elemento.


int main(){
Persona juan = consPersona("juan", 5);
Persona esteban = consPersona("esteban", 10);

// Devuelve el nombre de una persona

// cout << nombre(juan) << endl;;
// Devuelve el nombre de una persona

// cout << edad(juan) << endl;
// Devuelve la edad de una persona

// crecer(juan);
// Aumenta en uno la edad de la persona.

// cout << edad(juan) << endl;;

// cambioDeNombre("pepe", juan);
// Modifica el nombre una persona.

// cout << nombre(juan) << endl;;

// cout << esMayorQueLaOtra(juan, esteban) << endl;
// Dadas dos personas indica si la primera es mayor que la segunda.

// cout << nombre(laQueEsMayor(juan, esteban)) << endl;
// Dadas dos personas devuelve a la persona que sea mayor.
ArrayList arrayPrueba = newArrayListWith(20);

for(int i = 0; i < 20; i++){
    add(i + 1, arrayPrueba);
}

// cout << sumatoria(arrayPrueba);

// sucesores(arrayPrueba);

// for(int i = 0; i < 20; i++){
//     cout << get(i, arrayPrueba) << endl;
// }

// cout << pertenece(40, arrayPrueba);

// for(int i = 0; i < 20; i++){
//     cout << apariciones(i+1, append(arrayPrueba, arrayPrueba));    
// }

Pokemon pikachu = consPokemon("fuego");
Pokemon bulbasaur = consPokemon("planta");
Pokemon pokAgua = consPokemon("agua");

// cout << superaA(pokAgua, pikachu);

Pokemon* pokemones  = new Pokemon[3];
pokemones[0] = pikachu;
pokemones[1] = bulbasaur;
pokemones[2] = pokAgua;

Entrenador pepe = consEntrenador("juan", 3, pokemones);

Pokemon* pokemones2  = new Pokemon[1];
pokemones2[0] = pikachu;
// pokemones2[1] = bulbasaur;
// pokemones2[2] = pokAgua;

Entrenador tomas = consEntrenador("tomas", 1, pokemones);

cout << nombreDeEntrenador(pepe) << endl;
cout << cantidadDePokemon(pepe) << endl;
cout << cantidadDePokemonDe("fuego", pepe) << endl;
cout << tipoDePokemon(pokemonNro(1, pepe)) << endl;
cout << leGanaATodos(pepe, tomas) << endl;

}
#include "Entrenador.h"

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon){
    EntrenadorSt* newEntrenador = new EntrenadorSt;
    newEntrenador->nombre = nombre;
    newEntrenador->cantPokemon = cantidad;
    newEntrenador->pokemon = pokemon;
    return newEntrenador;
}
// Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve
// un entrenador.
string nombreDeEntrenador(Entrenador e){
    return e->nombre;
}
// Devuelve el nombre del entrenador.
int cantidadDePokemon(Entrenador e){
    return e->cantPokemon;
}
// Devuelve la cantidad de pokémon que posee el entrenador.
int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e){
    int cantidadHastaAhora = 0;
    for(int i = 0; i < e->cantPokemon; i++){
        if(e->pokemon[i]->tipo == tipo){
            cantidadHastaAhora++;
        }
    }
    return cantidadHastaAhora;
}
// Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
Pokemon pokemonNro(int i, Entrenador e){
    return e->pokemon[i-1];
}
// Devuelve el pokémon número i de los pokémon del entrenador.
// Precondición: existen al menos i − 1 pokémon.

bool tieneUnoQueLeGaneA(Entrenador e, Pokemon pk){
    int pokemonVistos = 0;
    while(pokemonVistos < cantidadDePokemon(e) && !superaA(pokemonNro((pokemonVistos + 1), e), pk)){
        pokemonVistos++;
    }
    return (pokemonVistos < cantidadDePokemon(e));
}
// Indica si el entrenador posee al menos un pokemon que le gane al pokemon dado.

bool leGanaATodos(Entrenador e1, Entrenador e2){
    int pokemonVistos = 0;
    while(pokemonVistos < cantidadDePokemon(e2) && tieneUnoQueLeGaneA(e1, pokemonNro((pokemonVistos + 1), e2))){
        pokemonVistos++;
    }
    return (pokemonVistos == cantidadDePokemon(e2));
}
// Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero
// posee al menos un pokémon que le gane.
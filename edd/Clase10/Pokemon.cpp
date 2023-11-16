#include "Pokemon.h"

Pokemon consPokemon(TipoDePokemon tipo){
    PokeSt* newPok = new PokeSt;
    newPok->tipo = tipo; newPok->vida = 100;
    return newPok;
}
// Dado un tipo devuelve un pokémon con 100 % de energía.
TipoDePokemon tipoDePokemon(Pokemon p){
    return p->tipo;
}
// Devuelve el tipo de un pokémon.
int energia(Pokemon p){
    return p->vida;
}
// Devuelve el porcentaje de energía.
void perderEnergia(int energia, Pokemon p){
    int vidaResultado = (p->vida) - energia;
    if(vidaResultado < 0){
        p->vida = 0;
    }else{
        p->vida = vidaResultado;
    }
}
// Le resta energía al pokémon.
bool superaA(Pokemon p1, Pokemon p2){
    return (
        (p1->tipo == "agua" &&  p2->tipo == "fuego")      || 
        (p1->tipo == "fuego" &&  p2->tipo == "planta")    || 
        (p1->tipo == "planta" &&  p2->tipo == "fuego")
    );
}
// Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera
// a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.

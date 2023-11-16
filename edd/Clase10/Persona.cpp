#include "Persona.h"

Persona consPersona(string nombre, int edad){
    PersonaSt* p = new PersonaSt;
    p->nombre = nombre; p-> edad = edad;
    return p;
}
// Devuelve una persona con tal nombre y edad.
string nombre(Persona p){
    return p->nombre;
}
// Devuelve el nombre de una persona
int edad(Persona p){
    return p->edad;
}
// Devuelve la edad de una persona
void crecer(Persona p){
    p->edad++;
}
// Aumenta en uno la edad de la persona.
void cambioDeNombre(string nombre, Persona p){
    p->nombre = nombre;
}
// Modifica el nombre una persona.
bool esMayorQueLaOtra(Persona p1, Persona p2){
    return p1->edad > p2->edad;
}
// Dadas dos personas indica si la primera es mayor que la segunda.
Persona laQueEsMayor(Persona p1, Persona p2){
    if(p1->edad > p2->edad){
        return p1;
    }
    return p2;
}
// Dadas dos personas devuelve a la persona que sea mayor.
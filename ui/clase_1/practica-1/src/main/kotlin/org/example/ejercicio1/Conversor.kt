package org.example.ejercicio1

import org.example.ejercicio1.medidas.Km
import org.example.ejercicio1.medidas.Medida
import org.example.ejercicio1.medidas.Milla

class Conversor {
    companion object {
        fun kmToMillas(km: Km): Milla = Milla(km.longitud * km.proporcionMillas())
        fun millasToKm(milla: Milla): Km = Km(milla.longitud * milla.proporcionKm())

        fun toMillas(medida: Medida): Milla = Milla(medida.longitud * medida.proporcionMillas())
        fun toKm(medida: Medida): Km = Km(medida.longitud * medida.proporcionKm())
    }
}
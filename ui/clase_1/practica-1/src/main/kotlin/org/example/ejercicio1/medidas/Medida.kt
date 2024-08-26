package org.example.ejercicio1.medidas

abstract class Medida(val longitud: Float) {
    abstract fun proporcionKm(): Float
    abstract fun proporcionMillas(): Float
}
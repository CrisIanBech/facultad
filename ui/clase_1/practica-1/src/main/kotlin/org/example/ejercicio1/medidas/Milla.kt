package org.example.ejercicio1.medidas

class Milla(longitud: Float): Medida(longitud) {
    override fun proporcionKm(): Float = 1.60934F
    override fun proporcionMillas(): Float = 1.0F
}
package org.example.ejercicio1.medidas

class Km(longitud: Float): Medida(longitud) {
    override fun proporcionKm(): Float = 1.0F
    override fun proporcionMillas(): Float = 1.60934F
}
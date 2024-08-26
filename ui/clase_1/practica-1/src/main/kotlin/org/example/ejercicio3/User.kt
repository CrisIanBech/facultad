package org.example.ejercicio3

import java.time.LocalDate

class User(
    val nombre: String,
    val apellido: String,
    val email: String,
    val fechaNacimiento: LocalDate,
    val seguidores: List<User>,
    val seguidos: List<User>
) {
    fun edad(): Int {
        val now = LocalDate.now()
        return fechaNacimiento.year - now.year
    }

    fun seguidoresMutuos(): List<User> {
        return seguidores.intersect(seguidos.toSet()).toList()
    }
}
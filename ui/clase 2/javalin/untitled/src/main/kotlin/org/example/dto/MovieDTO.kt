package org.example.dto

import org.example.domain.entities.Movie

class MovieDTO(
    movie: Movie,
    val title: String = movie.title,
    val description: String = movie.description,
    val releaseDate: String = movie.releaseDate.toString(),
    val actors: List<String> = movie.actors,
    val directors: List<String> = movie.directors,
    val rating: Float = movie.rating
)
package org.example.services.ranking

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.convertValue
import org.example.domain.entities.Movie

class RankingServiceImpl : RankingService {
    val movies: MutableList<Movie> = mutableListOf()

    init {
        val inputStream = javaClass.getResourceAsStream("/movies.json")
        val bytes = inputStream?.readBytes()
        val objectMapper = ObjectMapper().readTree(bytes)
        val moviesToAdd = ObjectMapper().convertValue<List<Movie>>(objectMapper)
        movies.addAll(moviesToAdd)
    }

    override fun findRanking(rating: Float, limit: Int): List<Movie> {
        return movies.filter { it.rating >= rating }.take(limit).sortedByDescending { it.rating }
    }
}
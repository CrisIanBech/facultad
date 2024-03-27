package org.example.services.search

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.convertValue
import org.example.domain.entities.Movie
import org.example.domain.search.SearchFilterChaineable

class SearchServiceImpl : SearchService {

    val movies: MutableList<Movie> = mutableListOf()

    init {
        val inputStream = javaClass.getResourceAsStream("/movies.json")
        val bytes = inputStream?.readBytes()
        val objectMapper = ObjectMapper().readTree(bytes)
        val moviesToAdd = ObjectMapper().convertValue<List<Movie>>(objectMapper)
        movies.addAll(moviesToAdd)
    }

    override fun search(filter: SearchFilterChaineable): List<Movie> {
        val maxPointsForFilter = filter.filterPriority()
        return movies
            .map { Pair(it, filter.filter(it)) }
            .filter { it.second > 0 || maxPointsForFilter == 0}
            .sortedByDescending { it.second }
            .map { it.first }
    }

}
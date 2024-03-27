package org.example.domain.search

import org.example.domain.entities.Movie

class DirectorsFilterChaineable(
    val directors: Set<String>,
    override val filterPriority: Int = if (directors.isNotEmpty()) 2 else 0
): SearchFilterChaineable() {
    override fun filterSelf(movie: Movie): Boolean {
        return movie.directors.toSet().containsAll(directors)
    }
}
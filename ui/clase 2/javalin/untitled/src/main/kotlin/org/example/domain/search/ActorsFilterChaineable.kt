package org.example.domain.search

import org.example.domain.entities.Movie

class ActorsFilterChaineable(
    val actors: Set<String>,
    override val filterPriority: Int = if (actors.isNotEmpty()) 1 else 0
): SearchFilterChaineable() {
    override fun filterSelf(movie: Movie): Boolean {
        return movie.actors.toSet().containsAll(actors)
    }
}
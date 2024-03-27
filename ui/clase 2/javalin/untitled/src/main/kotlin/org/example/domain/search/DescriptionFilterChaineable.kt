package org.example.domain.search

import org.example.domain.entities.Movie

class DescriptionFilterChaineable(val description: String, override val filterPriority: Int = 8): SearchFilterChaineable() {
    override fun filterSelf(movie: Movie): Boolean {
        return movie.description.contains(description)
    }
}
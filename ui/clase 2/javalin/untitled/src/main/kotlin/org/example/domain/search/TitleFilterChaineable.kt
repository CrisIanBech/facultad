package org.example.domain.search

import org.example.domain.entities.Movie

class TitleFilterChaineable(val title: String, override val filterPriority: Int = 8): SearchFilterChaineable() {
    override fun filterSelf(movie: Movie): Boolean {
        return movie.title.contains(title)
    }
}
package org.example.domain.search

import org.example.domain.entities.Movie

class SkipFilterChaineable(override val filterPriority: Int = 0) : SearchFilterChaineable() {
    override fun filterSelf(movie: Movie): Boolean {
        return true
    }
}
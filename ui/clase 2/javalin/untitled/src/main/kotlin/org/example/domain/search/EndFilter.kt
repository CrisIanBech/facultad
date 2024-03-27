package org.example.domain.search

import org.example.domain.entities.Movie

class EndFilter(override val filterPriority: Int = 0) : SearchFilter {
    override fun filterSelf(movie: Movie): Boolean {
        return true
    }

    override fun nextFilter(filter: SearchFilter) {
    }

    override fun filterPriority(): Int {
        return 0
    }

    override fun filter(movie: Movie): Int {
        return 0
    }
}
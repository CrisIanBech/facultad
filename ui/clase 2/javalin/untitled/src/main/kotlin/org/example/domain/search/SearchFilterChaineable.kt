package org.example.domain.search

import org.example.domain.entities.Movie

abstract class SearchFilterChaineable: SearchFilter {
    private var nextFilter: SearchFilter = EndFilter()
    abstract override val filterPriority: Int

    override fun nextFilter(filter: SearchFilter) { nextFilter = filter }

    override fun filterPriority(): Int = filterPriority + nextFilter.filterPriority()

    abstract override fun filterSelf(movie: Movie): Boolean

    override fun filter(movie: Movie): Int {
        return (if (filterSelf(movie)) filterPriority else 0) + nextFilter.filter(movie)
    }
}
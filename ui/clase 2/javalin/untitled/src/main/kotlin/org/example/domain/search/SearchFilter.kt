package org.example.domain.search

import org.example.domain.entities.Movie

interface SearchFilter {
    val filterPriority: Int
    fun nextFilter(filter: SearchFilter)
    fun filterPriority(): Int
    fun filterSelf(movie: Movie): Boolean
    fun filter(movie: Movie): Int
}
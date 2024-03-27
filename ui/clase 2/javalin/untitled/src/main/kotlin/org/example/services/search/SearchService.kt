package org.example.services.search

import org.example.domain.entities.Movie
import org.example.domain.search.SearchFilterChaineable

interface SearchService {
    fun search(filter: SearchFilterChaineable): List<Movie>
}
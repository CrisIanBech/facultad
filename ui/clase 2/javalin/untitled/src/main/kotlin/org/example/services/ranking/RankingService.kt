package org.example.services.ranking

import org.example.domain.entities.Movie

interface RankingService {
    fun findRanking(rating: Float, limit: Int): List<Movie>
}
package org.example.controllers.ranking

import io.javalin.http.Context
import io.javalin.http.queryParamAsClass
import org.example.dto.MovieDTO
import org.example.services.ranking.RankingService

class RankingControllerImpl(val rankingService: RankingService) : RankingController {
    override fun findRanking(ctx: Context) {
        val minRating: Float = ctx.queryParamAsClass<Float>("min_rating")
            .allowNullable()
            .check({ it?.let { it in 0.0..10.0 } ?: true }, "rating should be in range 0 to 10")
            .get() ?: 0F
        val limit: Int = ctx.queryParamAsClass<Int>("limit")
            .allowNullable()
            .check({ it?.let{ it >= 0 } ?: true }, "limit should be a positive number")
            .get() ?: Int.MAX_VALUE

        val movies = rankingService.findRanking(minRating, limit).map { MovieDTO(it) }
        ctx.json(movies)
    }
}
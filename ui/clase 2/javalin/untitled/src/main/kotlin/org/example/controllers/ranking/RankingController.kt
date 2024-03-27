package org.example.controllers.ranking

import io.javalin.http.Context

interface RankingController {
    fun findRanking(ctx: Context)
}
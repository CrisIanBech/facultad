package org.example.app

import io.javalin.Javalin
import io.javalin.apibuilder.ApiBuilder.get
import org.example.controllers.ranking.RankingController
import org.example.controllers.search.SearchController

class IMDBApi(val searchController: SearchController, val rankingController: RankingController) {
    fun start() {
        Javalin.create { config ->
            config.router.apiBuilder {
                get("/searchby", searchController::search)
                get("/ranking", rankingController::findRanking)
            }
        }.start(8080)
    }
}

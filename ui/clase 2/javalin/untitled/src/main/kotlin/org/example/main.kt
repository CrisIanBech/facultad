package org.example

import org.example.app.IMDBApi
import org.example.controllers.ranking.RankingControllerImpl
import org.example.controllers.search.SearchControllerImpl
import org.example.services.ranking.RankingServiceImpl
import org.example.services.search.SearchServiceImpl

fun main(args: Array<String>) {
    val searchService = SearchServiceImpl()
    val rankingService = RankingServiceImpl()
    val searchController = SearchControllerImpl(searchService)
    val rankingController = RankingControllerImpl(rankingService)
    IMDBApi(searchController, rankingController).start()
}


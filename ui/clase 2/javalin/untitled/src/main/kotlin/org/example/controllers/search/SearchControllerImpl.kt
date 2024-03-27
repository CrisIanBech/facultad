package org.example.controllers.search

import io.javalin.http.Context
import org.example.domain.search.*
import org.example.dto.MovieDTO
import org.example.services.search.SearchService

class SearchControllerImpl(val searchService: SearchService): SearchController {
    override fun search(ctx: Context) {
        val title = ctx.queryParamAsClass("title", String::class.java).allowNullable().get()
        val description = ctx.queryParamAsClass("description", String::class.java).allowNullable().get()
        val actors = ctx.queryParams("actors")
        val directors = ctx.queryParams("directors")

        val titleFilter: SearchFilterChaineable = title?.let { TitleFilterChaineable(it) } ?: SkipFilterChaineable()
        val descriptionFilter: SearchFilterChaineable = description?.let { DescriptionFilterChaineable(it) } ?: SkipFilterChaineable()
        val actorsFilter: SearchFilterChaineable = actors?.let { ActorsFilterChaineable(it.toSet()) } ?: SkipFilterChaineable()
        val directorsFilter: SearchFilterChaineable = directors?.let { DirectorsFilterChaineable(it.toSet()) } ?: SkipFilterChaineable()

        titleFilter.nextFilter(descriptionFilter)
        descriptionFilter.nextFilter(actorsFilter)
        actorsFilter.nextFilter(directorsFilter)

        val filteredMovies = searchService.search(titleFilter).map { MovieDTO(it) }
        ctx.json(filteredMovies)
    }
}
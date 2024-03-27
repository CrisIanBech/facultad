package org.example.controllers.search

import io.javalin.http.Context

interface SearchController {
    fun search(ctx: Context)
}
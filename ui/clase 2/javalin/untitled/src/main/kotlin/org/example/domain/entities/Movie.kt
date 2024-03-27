package org.example.domain.entities

import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class Movie(
    val title: String,
    val description: String,
    val releaseDate: LocalDate,
    val actors: List<String>,
    val directors: List<String>,
    val rating: Float
) {
    @JsonCreator
    constructor(
        @JsonProperty("title") title: String,
        @JsonProperty("description") description: String,
        @JsonProperty("releaseDate") releaseDate: String,
        @JsonProperty("actors") actors: List<String>,
        @JsonProperty("directors") directors: List<String>,
        @JsonProperty("rating") rating: Float
    ) : this(
        title,
        description,
        LocalDate.parse(releaseDate, DateTimeFormatter.ofPattern("yyyy-MM-dd")),
        actors,
        directors,
        rating
    )
}
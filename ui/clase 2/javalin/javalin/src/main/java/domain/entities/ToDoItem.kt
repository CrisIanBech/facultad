package domain.entities

import java.time.LocalDate
import java.util.*

class ToDoItem(
        val id: Long,
        val title: String,
        val description: String,
        val date: LocalDate,
        var state: ToDoState
)
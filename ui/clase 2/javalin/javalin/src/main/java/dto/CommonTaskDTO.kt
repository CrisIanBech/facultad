package dto

import domain.entities.ToDoItem
import domain.entities.ToDoState
import java.util.*

class CommonTaskDTO(
        task: ToDoItem,
        val id: Long = task.id,
        val title: String = task.title,
        val description: String = task.description,
        val date: String = task.date.toString(),
        val state: String = task.state.toString(),
) {
}
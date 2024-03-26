package domain

import dao.task.CommonTaskCreationDAO
import dao.task.CommonTaskModificationDAO
import domain.entities.ToDoItem
import domain.entities.ToDoState
import java.time.LocalDate

class ToDoItemFactory {
    companion object {
        fun isValidStringForState(state: String): Boolean {
            return ToDoState.entries.toTypedArray().any {
                it.name.lowercase() == state.lowercase()
            }
        }

        fun stateFromString(state: String): ToDoState {
            return when(state.lowercase()) {
                "completed" -> ToDoState.Completed
                "pending" -> ToDoState.Pending
                else -> { throw IllegalArgumentException("uknown state $state") }
            }
        }

        fun createFromDAO(taskToAddDAO: CommonTaskCreationDAO, id: Long): ToDoItem {
            return ToDoItem(
                    id = id,
                    title = taskToAddDAO.title,
                    description = taskToAddDAO.description,
                    date = DateFactory.currentTime(),
                    state = ToDoState.Pending
            )
        }

        fun createFromDAO(taskToModifyDAO: CommonTaskModificationDAO, id: Long, date: LocalDate): ToDoItem {
            return ToDoItem(
                    id = id,
                    title = taskToModifyDAO.title,
                    description = taskToModifyDAO.description,
                    date = date,
                    state = stateFromString(taskToModifyDAO.state)
            )
        }
    }
}

package service

import domain.entities.ToDoItem
import domain.entities.ToDoState

class ToDoServiceImpl : ToDoService {
    val tasks: MutableList<ToDoItem> = mutableListOf()

    override fun allTasks(): List<ToDoItem> {
        return tasks
    }

    override fun task(id: Long): ToDoItem {
        return tasks.find {
            toDoItem -> toDoItem.id == id
        } ?: throw NoSuchElementException()
    }

    override fun addTask(task: ToDoItem) {
        tasks.add(task)
    }

    override fun modify(id: Long, newTask: ToDoItem) {
        val indexOfReplacedTask = tasks.indexOfFirst {
            toDoItem -> toDoItem.id == id
        }
        if (indexOfReplacedTask == -1) throw NoSuchElementException()
        tasks.removeAt(indexOfReplacedTask)
        tasks.add(indexOfReplacedTask, newTask)
    }

    override fun delete(id: Long) {
        val itemToRemoveIndex = tasks.indexOfFirst {
            toDoItem -> toDoItem.id == id
        }
        if(itemToRemoveIndex == -1) throw NoSuchElementException()
        tasks.removeAt(itemToRemoveIndex)
    }

    override fun markDone(id: Long) {
        setStateForTaskWithId(ToDoState.Completed, id)
    }

    override fun markUndone(id: Long) {
        setStateForTaskWithId(ToDoState.Pending, id)
    }

    override fun potentialID(): Long {
        return (tasks.maxOfOrNull { it.id } ?: -1) + 1
    }

    private fun setStateForTaskWithId(state: ToDoState, id: Long) {
        val taskToMark = tasks.find { it.id == id }
        if (taskToMark == null) { throw NoSuchElementException() }
        taskToMark.state = state
    }
}

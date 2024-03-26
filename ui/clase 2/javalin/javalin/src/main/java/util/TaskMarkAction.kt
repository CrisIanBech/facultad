package util

import service.ToDoService

abstract class TaskMarkAction() {
    abstract fun mark(toDoService: ToDoService, id: Long)
}

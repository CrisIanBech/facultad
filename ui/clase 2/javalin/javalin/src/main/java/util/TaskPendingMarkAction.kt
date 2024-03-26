package util

import service.ToDoService

class TaskPendingMarkAction : TaskMarkAction() {
    override fun mark(toDoService: ToDoService, id: Long) {
        toDoService.markUndone(id)
    }
}
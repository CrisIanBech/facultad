package util

import service.ToDoService

class TaskCompletedMarkAction : TaskMarkAction() {
    override fun mark(toDoService: ToDoService, id: Long) {
        toDoService.markDone(id)
    }
}

package service

import domain.entities.ToDoItem

interface ToDoService {
    fun allTasks(): List<ToDoItem>
    fun task(id: Long): ToDoItem
    fun addTask(task: ToDoItem)
    fun modify(id: Long, newTask: ToDoItem)
    fun delete(id: Long)
    fun markDone(id: Long)
    fun markUndone(id: Long)
    fun potentialID(): Long
}
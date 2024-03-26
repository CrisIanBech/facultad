package controller

import domain.entities.ToDoItem
import io.javalin.http.Context

interface ToDoController {
    fun allTasks(ctx: Context)
    fun task(ctx: Context)
    fun addTask(ctx: Context)
    fun modify(ctx: Context)
    fun delete(ctx: Context)
    fun markDone(ctx: Context)
    fun markUndone(ctx: Context)
}
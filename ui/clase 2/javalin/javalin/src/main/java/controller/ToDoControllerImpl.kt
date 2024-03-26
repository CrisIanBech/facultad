package controller

import domain.ToDoItemFactory
import dao.task.CommonTaskCreationDAO
import dao.task.CommonTaskModificationDAO
import domain.DateFactory
import domain.entities.ToDoItem
import dto.CommonTaskListDTO
import domain.entities.ToDoState
import dto.CommonTaskDTO
import io.javalin.http.Context
import io.javalin.http.NotFoundResponse
import io.javalin.http.bodyValidator
import service.ToDoService
import util.TaskCompletedMarkAction
import util.TaskMarkAction
import util.TaskPendingMarkAction

class ToDoControllerImpl(val toDoService: ToDoService) : ToDoController {
    override fun allTasks(ctx: Context) {
        val tasks = toDoService.allTasks().map {
            CommonTaskDTO(it)
        }
        ctx.json(CommonTaskListDTO(tasks))
    }

    override fun task(ctx: Context) {
        val id = idFromContext(ctx)
        try {
            val task = toDoService.task(id)
            ctx.json(CommonTaskDTO(task))
        } catch (e: NoSuchElementException) {
            throw NotFoundResponse("task with id $id not found")
        }
    }

    override fun addTask(ctx: Context) {
        val taskToAddDAO = ctx.bodyValidator<CommonTaskCreationDAO>()
                .check({ it.title.isNotEmpty() }, "title must not be empty")
                .check({ it.description.isNotEmpty() }, "description must not be empty")
                .get()
        val id = toDoService.potentialID()
        val taskToAdd = ToDoItemFactory.createFromDAO(taskToAddDAO, id)
        toDoService.addTask(taskToAdd)
        ctx.status(201)
    }

    override fun modify(ctx: Context) {
        val id = idFromContext(ctx)
        lateinit var lastTask: ToDoItem
        try {
            lastTask = toDoService.task(id)
        } catch (e: NoSuchElementException) {
            throw NotFoundResponse("task with id $id not found")
        }
        val taskToModifyDAO = ctx.bodyValidator<CommonTaskModificationDAO>()
                .check({ it.title.isNotEmpty() }, "title must not be empty")
                .check({ it.description.isNotEmpty() }, "description must not be empty")
                .check({ ToDoItemFactory.isValidStringForState(it.state) }, "task state must be valid")
                .check({
                        ToDoItemFactory.isValidStringForState(it.state)
                                && lastTask.state != ToDoState.Completed
                       }, "task must not be completed")
                .get()
        val taskToModify = ToDoItemFactory.createFromDAO(taskToModifyDAO, id, lastTask.date)
        toDoService.modify(id, taskToModify)
        ctx.status()
    }

    override fun delete(ctx: Context) {
        val id = idFromContext(ctx)
        try {
            toDoService.delete(id)
        } catch (e: NoSuchElementException) {
            throw NotFoundResponse("task with id $id not found")
        }
        ctx.status(204)
    }

    override fun markDone(ctx: Context) {
        setStateForTaskWithId(ctx, TaskCompletedMarkAction())
    }

    override fun markUndone(ctx: Context) {
        setStateForTaskWithId(ctx, TaskPendingMarkAction())
    }

    private fun setStateForTaskWithId(ctx: Context, markAction: TaskMarkAction) {
        val id = idFromContext(ctx)
        try {
            markAction.mark(toDoService, id)
        } catch (e: NoSuchElementException) {
            throw NotFoundResponse("task with id $id not found")
        }
        ctx.status(200)
    }

    private fun idFromContext(ctx: Context) = ctx.pathParamAsClass<Long>("id", Long::class.java).check({
        it >= 0
    }, "id must be positive").get()

}
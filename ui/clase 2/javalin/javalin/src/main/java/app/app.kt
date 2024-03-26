package app

import controller.ToDoControllerImpl
import io.javalin.Javalin
import io.javalin.apibuilder.ApiBuilder.*
import service.ToDoServiceImpl

fun main() {
    val service = ToDoServiceImpl()
    val controller = ToDoControllerImpl(service)
    Javalin.create { config ->
        config.http.defaultContentType = "application/json"
        config.router.apiBuilder {
            path("tasks") {
                get(controller::allTasks)
                path("{id}") {
                    get(controller::task)
                    put(controller::modify)
                }
                post(controller::addTask)
            }
            path("task") {
                path("{id}") {
                    delete(controller::delete)
                    put("done", controller::markDone)
                    put("undone", controller::markUndone)
                }
            }
        }
    }.start(8080)
}
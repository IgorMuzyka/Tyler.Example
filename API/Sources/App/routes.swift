
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get("users", use: UserController.randomUsers)


    router.get("todos", use: TodoController.index)
    router.post("todo/new", use: TodoController.create)
    router.delete("todo/delete", Todo.parameter, use: TodoController.delete)
}


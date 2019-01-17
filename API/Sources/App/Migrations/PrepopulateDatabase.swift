
import FluentSQLite

final class PrepopulateDatabase: Migration {

    typealias Database = SQLiteDatabase

    static func prepare(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        let todos = [
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
            Todo(title: "One", isDone: false),
            Todo(title: "Two", isDone: false),
            Todo(title: "Three", isDone: true),
        ]

        return Future<Void>.andAll(todos.map {
            $0.save(on: conn).map(to: Void.self) { _ in }
        }, eventLoop: conn.eventLoop)
    }

    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return Todo.query(on: conn).all().flatMap { todos in
            return Future<Void>.andAll(todos.map {
                $0.delete(on: conn).map(to: Void.self) { _ in }
            }, eventLoop: conn.eventLoop)
        }
    }

}

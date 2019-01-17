
import FluentSQLite
import Vapor

final class Todo: SQLiteModel {

    var id: Int?
    var title: String
    var isDone: Bool
    var createdAt: Date?

    init(id: Int? = nil, title: String, isDone: Bool) {
        self.id = id
        self.isDone = isDone
        self.title = title
    }

    func willCreate(on conn: SQLiteConnection) throws -> EventLoopFuture<Todo> {
        createdAt = Date()
        return Future.map(on: conn) { self }
    }
}

extension Todo: Migration { }
extension Todo: Content { }
extension Todo: Parameter { }

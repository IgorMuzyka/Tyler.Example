
import Vapor
import TylerSupportAppleUIKit
import Anchor

final class TodoController {

//    static func index(_ req: Request) throws -> Future<[Todo]> {
//        return Todo.query(on: req).all()
//    }

    static func index(_ req: Request) throws -> Future<ScrollView> {
        return Todo.query(on: req).all().flatMap { todos in

            let items = todos.map(TodoTile.init)

            let scrollView = ScrollView(items: items, orientation: .vertical)
                .anchor(Anchor(.self).left.bottom.right)
                .anchor(Anchor(.self).topMargin.constant(50))
                .style(UIViewStyle.backgroundColor(.let(.white)))

            EqualSizeFixedSpacingLayout.layout(tiles: items, in: scrollView.contentView, with: 4, orientation: .vertical)

            return Future.map(on: req) { scrollView }
        }
    }

    static func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    static func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}

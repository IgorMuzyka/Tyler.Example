
import Tyler
import TylerSupportAppleUIKit
import TylerSupportAppleCommon
import Variable
import Anchor
import Substitutes

public final class TodoTile: Tile {

    init(todo: Todo) {
        let box = Tile(UIKitViewType.view)
        let button = Button(text: .let(""), action: NavigationAction(destination: "users"))
        let text: AttributedString

        if todo.isDone {
            text = todo.title.attributed()
                .add(.strikethrough(.solid, .black))
                .add(.foregroundColor(.black))

        } else {
            text = todo.title.attributed().add(.foregroundColor(.black))
        }

        let title = Label(attributedText: .let(text))
        let date = Label(text: .let("10/04/1992"), color: .let(.gray))

        box
            .anchor(box.anchor.size.equal.to(20))
            .anchor(box.anchor.centerY)
            .anchor(box.anchor.left.constant(10))
            .style(.cornerRadius(.let(10)))
            .style(.clipsToBounds(.let(true)))

        button
            .anchor(button.anchor.size.equal.to(20))
            .anchor(button.anchor.centerY)
            .anchor(button.anchor.left.constant(10))

        if todo.isDone {
            box.style(UIViewStyle.backgroundColor(.let(.black)))
        } else {
            box.style(UIViewStyle.backgroundColor(.let(.white)))
            box.style(.borderColor(.let(.black)))
            box.style(.borderWidth(.let(2)))
        }

        title
            .anchor(title.anchor.left.to(box.anchor.right).constant(10))
            .anchor(title.anchor.top.constant(10))
            .anchor(title.anchor.height.equal.to(12))

        date
            .anchor(date.anchor.left.to(title.anchor.left))
            .anchor(date.anchor.top.to(title.anchor.bottom).constant(10))
            .anchor(date.anchor.height.equal.to(12))

        super.init(UIKitViewType.view.rawValue, name: nil, tiles: [box, title, date, button])

        style(UIViewStyle.backgroundColor(.let(.white)))
        anchor(Anchor(.self).height.equal.to(50))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

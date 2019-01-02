
import Tyler
import TylerSupportAppleUIKit
import Tag

public class ExampleTile: Tile {

    public init() {
        let a = Tile(UIKitViewType.view, name: "A", tiles: [])
        let b = Tile(UIKitViewType.view, name: "B", tiles: [])
        let c = Tile(UIKitViewType.view, name: "C", tiles: [])

        super.init(UIKitViewType.view.rawValue, name: "example", tiles: [a, b, c])

        anchor(self.anchor.top.left.right.bottom)
        style(UIViewStyle.backgroundColor(.let(.black)))

        anchors(
            [
                a.anchor.top.left,
                a.anchor.height.width.equal.to(150),

                b.anchor.top.to(a.anchor.bottom).equal.to(10),
                b.anchor.height.width.equal.to(50),
                b.anchor.centerY,

                c.anchor.right.bottom.left,
                c.anchor.top.to(b.anchor.bottom).equal.to(40)

//                a.anchor.top.left.right.centerY,
//                b.anchor.left.right
//                a.anchor.left.top.bottom,
//                b.anchor.right.centerY,
//                a.anchor.right.to(b.anchor.left),
//                b.anchor.height.equal.to(150),
//                a.anchor.width.equal.to(b.anchor.width)
            ].tag(.portrait)

            +

            [
//                a.anchor.top.centerX,
//                b.anchor.bottom.left.right,
//                a.anchor.bottom.to(b.anchor.top),
//                a.anchor.width.equal.to(50),
//                a.anchor.height.equal.to(b.anchor.height)
            ].tag(.landscape)
        )

        a.style(style: UIViewStyle.backgroundColor(.let(.red)))
        b.style(style: UIViewStyle.backgroundColor(.let(.green)))
        c.style(style: UIViewStyle.backgroundColor(.let(.blue)))

//        a.style(style: UIViewStyle.backgroundColor(.let(.green)), tags: [.portrait])
//        b.style(style: UIViewStyle.backgroundColor(.let(.blue)), tags: [.portrait])
//        a.style(style: UIViewStyle.backgroundColor(.let(.cyan)), tags: [.landscape])
//        b.style(style: UIViewStyle.backgroundColor(.let(.magenta)), tags: [.landscape])
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

extension Tag {

    internal static var portrait: Tag {
        return .custom("portrait")
    }

    internal static var landscape: Tag {
        return .custom("landscape")
    }

    internal static var currentOrientation: Tag {
        return UIDevice.current.orientation.isLandscape ? .landscape : .portrait
    }
}

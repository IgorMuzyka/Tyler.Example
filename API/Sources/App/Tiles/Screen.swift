
import Tyler
import TylerSupportAppleUIKit
import Anchor
import Vapor
import Variable

final class Screen: Tile, Content {

    public private(set) var statusBar: Tile!
    public private(set) var container: Tile!

    public init(tile: Tile) {
        statusBar = Tile(UIKitViewType.view)
        container = Tile(UIKitViewType.view, tiles: [tile])

        super.init(UIKitViewType.view.rawValue, tiles: [statusBar, container])

        anchors([
            Anchor(.self).left.bottom.right.top,
            statusBar.anchor.top.left.right,
            container.anchor.left.bottom.right,
            statusBar.anchor.height.equal.to(.var(name: "statusBar.height")),
            container.anchor.top.to(statusBar.anchor.bottom).constant(0)
        ])

        style(UIViewStyle.backgroundColor(.let(.white)))
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        statusBar = tiles.first
        container = tiles.last
    }
}

//
//class TopBar: Tile {
//
//    public init() {
//        super.init(UIKitViewType.view.rawValue)
//    }
//
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//}

//class StatusBar: Tile {
//
//    public init() {
//        super.init(UIKitViewType.view.rawValue)
//    }
//
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//}

//class BottomBar: Tile {
//
//}


import Tyler
import TylerSupportAppleUIKit
import Anchor
import Variable
import Substitutes

final public class ErrorTile: Tile {

    public private(set) var label: Tile!

    public init(error: Error) {
        label = Tile(UIKitViewType.label)
            .anchor(Anchor(.self).center)
            .style(UILabelStyle.textColor(.let(.white)))
            .style(UILabelStyle.text(.let(error.localizedDescription)))

        super.init(UIKitViewType.view.rawValue, name: nil, tiles: [label])

        anchor(Anchor(.self).top.left.bottom.right)
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        label = self.tiles.first!
    }
}

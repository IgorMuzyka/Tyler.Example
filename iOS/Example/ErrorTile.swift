
import Tyler
import TylerSupportAppleUIKit
import Anchor
import Variable
import Substitutes

final public class ErrorTile: Tile {

    public private(set) var label: Tile!

    public init(error: Error) {
//        let text = error.localizedDescription

        let text = "\(error)"

        label = Tile(UIKitViewType.label)
            .anchor(Anchor(.self).center.left.right)
            .style(UILabelStyle.textColor(.let(.white)))
            .style(UILabelStyle.text(.let(text)))
            .style(UILabelStyle.numberOfLines(.let(0)))
            .style(UILabelStyle.lineBreakMode(.let(.byWordWrapping)))
            .style(UILabelStyle.minimumScaleFactor(.let(0.001)))
            .style(UILabelStyle.adjustsFontSizeToFitWidth(.let(true)))

        super.init(UIKitViewType.view.rawValue, name: nil, tiles: [label])

        anchor(Anchor(.self).top.left.bottom.right)
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        label = self.tiles.first!
    }
}

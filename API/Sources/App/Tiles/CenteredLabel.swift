
import Tyler
import TylerSupportAppleUIKit
import Anchor
import Variable
import Substitutes

final public class CenteredLabel: Tile {

    public private(set) var label: Tile!

    public init(name: String? = nil, text: Variable<String>) {
        label = Tile(UIKitViewType.label)
            .anchor(Anchor(.self).center)
            .style(UILabelStyle.textColor(.let(.white)))
            .style(UILabelStyle.text(text))

        super.init(UIKitViewType.view.rawValue, name: name, tiles: [label])
    }

    public convenience init(name: String? = nil, attributedText: Variable<AttributedString>) {
        self.init(name: name, text: .let(""))
        label.style(.attributedText(attributedText))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        label = self.tiles.first!
    }
}

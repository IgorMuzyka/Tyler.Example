
import Tyler
import TylerSupportAppleUIKit
import Anchor
import Vapor

final class ScrollView: Tile, Content {

    public private(set) var contentView: Tile!

    public init(name: String? = nil, items: [Tile], orientation: Orientation) {
        contentView = Tile(UIKitViewType.view, tiles: items)

        super.init(UIKitViewType.scrollView.rawValue, name: name, tiles: [contentView])

        style(.isScrollEnabled(.let(true)))

        anchor(contentView.anchor.leftMargin.rightMargin.bottomMargin.topMargin)

        switch orientation {
        case .horizontal:
            anchor(contentView.anchor.height.centerY)

            style(.showsHorizontalScrollIndicator(.let(true)))
        case .vertical:
            anchor(contentView.anchor.width.centerX)

            style(.showsVerticalScrollIndicator(.let(true)))
        }
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

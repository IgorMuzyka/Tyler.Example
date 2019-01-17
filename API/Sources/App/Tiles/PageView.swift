
import Tyler
import TylerSupportAppleUIKit
import Vapor
import Anchor

final class PageView: Tile, Content {

    public init(name: String? = nil, pages: [Tile], orientation: Orientation) {
        let container = Tile(UIKitViewType.view, tiles: pages)

        super.init(UIKitViewType.scrollView.rawValue, name: name, tiles: [container])

        EqualSizeFixedSpacingLayout.layout(tiles: container.tiles, in: container, orientation: orientation)

        style(.isPagingEnabled(.let(true)))
        style(.isScrollEnabled(.let(true)))


        anchor(container.anchor.topMargin.bottomMargin.leftMargin.rightMargin)

        switch orientation {
        case .horizontal:
            anchor(container.anchor.width.equal.to(self).multiplier(pages.count))
            anchor(container.anchor.height.centerY)
            style(.showsHorizontalScrollIndicator(.let(false)))
        case .vertical:
            anchor(container.anchor.height.equal.to(self).multiplier(pages.count))
            anchor(container.anchor.width.centerX)
            style(.showsVerticalScrollIndicator(.let(false)))
        }

    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}


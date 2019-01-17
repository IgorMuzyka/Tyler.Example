
import Tyler
import Anchor

enum EqualSizeFixedSpacingLayout {

    static func layout(tiles: [Tile], in container: Tile, with spacing: Double = 0, orientation: Orientation, reversed: Bool = false) {

        guard tiles.count >= 2 else { return }

        let items = ((reversed) ? tiles.reversed() : tiles)

        var anchors: [[Anchor]] = items.sequentialPairs().map { (tile, nextTile) in
            tie(tile: tile, to: nextTile, with: spacing, orientation: orientation)
        }

        if orientation == .horizontal {
            anchors.append([items.first!.anchor.left, items.last!.anchor.right])
            anchors.append(items.map { $0.anchor.top.bottom })
        } else {
            anchors.append([items.first!.anchor.top, items.last!.anchor.bottom])
            anchors.append(items.map { $0.anchor.left.right })
        }

        container.anchors(anchors.flatMap { $0 })
    }

    static func tie(tile: Tile, to anotherTile: Tile, with spacing: Double, orientation: Orientation) -> [Anchor] {
        if orientation == .horizontal {
            return [
                tile.anchor.right.to(anotherTile.anchor.left).constant(-spacing),
                tile.anchor.width.equal.to(anotherTile.anchor.width)
            ]
        } else {
            return [
                tile.anchor.bottom.to(anotherTile.anchor.top).constant(-spacing),
                tile.anchor.height.equal.to(anotherTile.anchor.height)
            ]
        }
    }
}


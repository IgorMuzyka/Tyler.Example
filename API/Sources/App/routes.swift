
import Vapor

import Tyler
import TylerSupportAppleUIKit
import TylerSupportAppleCommon
//import Tag
import Anchor

import Substitutes
import Variable

//import Random

/// Register your application's routes here.
public func routes(_ router: Router) throws {


    router.get("users") { (request: Request) -> Future<PageView> in
        return try request.client().get("https://uinames.com/api/?amount=20&region=england&ext").flatMap { response in
            return try response.content.decode([RandomUser].self).flatMap { users in
                return request.future(
                    PageView(name: "pageView", pages: users.map { user in
                        return RandomUserTile(user: user)
                            .style(UIViewStyle.backgroundColor(.let(.random)))
                    }, orientation: .horizontal)
                        .anchor(Anchor(.self).top.left.bottom.right)


//                    RandomUserTile(user: users.first!)
//                        .style(UIViewStyle.backgroundColor(.let(.random)))
//                        .anchor(Anchor(.self).top.left.bottom.right)

//                    ImageView(url: users.first!.photo)
//                    PageView(pages: users.map {
//                        return RandomUserTile(user: $0)
//                    })
                )
            }
        }
    }
}

//import Variable

extension Number {

    public static var random: Number {
        return Number(Double.random(in: 0...1))
//        return Number(try! OSRandom().generate(Double.self))
    }
}

extension Color {

    public static var random: Color {
        return Color(red: .random, green: .random, blue: .random)
    }
//
//    public static var black: Color { return Color(red: 0, green: 0, blue: 0) }
//    public static var darkGray: Color { return Color(red: 0.333, green: 0.333, blue: 0.333) }
//    public static var lightGray: Color { return Color(red: 0.667, green: 0.667, blue: 0.667) }
//    public static var white: Color { return Color(red: 1, green: 1, blue: 1) }
//    public static var gray: Color { return Color(red: 0.5, green: 0.5, blue: 0.5) }
//    public static var red: Color { return Color(red: 1, green: 0, blue: 0) }
//    public static var green: Color { return Color(red: 0, green: 1, blue: 0) }
//    public static var blue: Color { return Color(red: 0, green: 0, blue: 1) }
//    public static var cyan: Color { return Color(red: 0, green: 1, blue: 1) }
//    public static var yellow: Color { return Color(red: 1, green: 1, blue: 0) }
//    public static var magenta: Color { return Color(red: 1, green: 0, blue: 1) }
//    public static var orange: Color { return Color(red: 1, green: 0.5, blue: 0) }
//    public static var purple: Color { return Color(red: 0.5, green: 0, blue: 0.5) }
//    public static var brown: Color { return Color(red: 0.6, green: 0.4, blue: 0.2) }
//    public static var clear: Color { return Color(red: 0, green: 0, blue: 0, alpha: 0) }

}

struct RandomUser: Content {

    let name: String
    let surname: String
    let email: String
    let photo: String
    let credit_card: CreditCard

    struct CreditCard: Content {

        let expiration: String
        let number: String
        let pin: Int
        let security: Int
    }
}

final public class ImageView: Tile, Content {

    init(url: String) {
        super.init(UIKitViewType.imageView.rawValue, tiles: [])
        style(UIImageViewStyle.url(.let(url)))
        style(UIViewStyle.contentMode(.let(.scaleAspectFit)))
        style(UIViewStyle.backgroundColor(.let(.green)))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

final public class RandomUserTile: Tile, Content {

    init(name: String? = nil, user: RandomUser) {
        let imageView = ImageView(url: user.photo)
        let username = Label(text: .let(user.name + " " + user.surname), color: .let(.random))
        
        imageView
            .anchor(imageView.anchor.height.width.equal.to(150))
            .anchor(imageView.anchor.top.constant(50))
            .anchor(imageView.anchor.left.constant(10))
            .style(UIViewStyle.backgroundColor(.let(.random)))
            .style(CALayerStyle.cornerRadius(.let(9.375)))
            .style(UIViewStyle.clipsToBounds(.let(true)))

        username

            .anchor(username.anchor.left.to(imageView.anchor.right).constant(10))
            .anchor(username.anchor.right.constant(-10))
            .anchor(username.anchor.top.to(imageView.anchor.top))

        super.init(UIKitViewType.view.rawValue, tiles: [imageView, username])

        style(UIViewStyle.backgroundColor(.let(.red)))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

final public class CreditCardTile: Tile {

    init(name: String? = nil, creditCard: RandomUser.CreditCard) {
        let number = Label(text: .let(creditCard.number))
        let expiration = Label(text: .let(creditCard.expiration))

        number.anchors([
            number.anchor.top.left.right.equal.to(20)
        ])

        super.init(UIKitViewType.view.rawValue, tiles: [number, expiration])

        anchor(Anchor(.self).width.equal.to(Anchor(.self).height).multiplier(1/3))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

final public class Label: Tile {

    public init(name: String? = nil, text: Variable<String>, color: Variable<Color> = .var(name: "textColor")) {
        super.init(UIKitViewType.label.rawValue, name: name, tiles: [])
        style(UILabelStyle.textColor(color))
        style(UILabelStyle.text(text))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

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
            anchor(container.anchor.height)
            anchor(container.anchor.centerY)
            style(.showsHorizontalScrollIndicator(.let(false)))
        case .vertical:
            anchor(container.anchor.height.equal.to(self).multiplier(pages.count))
            anchor(container.anchor.width)
            anchor(container.anchor.centerX)
            style(.showsVerticalScrollIndicator(.let(false)))
        }

    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

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

/// Pretty much self explanatory
public enum Orientation: StringLiteralType {

    case horizontal
    case vertical
}

extension Orientation {

    public var opposite: Orientation {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        }
    }
}

internal extension Array {

    internal static func populate(amount: Int, generator: () -> Element) -> Array {
        guard amount > 0 else { return [] }
        return (0 ..< amount).reduce([]) { array, _ in
            array + [generator()]
        }
    }
}

internal extension Array {

    internal func shifted(by shift: Int) -> Array {
        let loop = Loop(self)

        return (0 ..< loop.count).reduce([]) { array, i in
            array + [loop[i + shift]]
        }
    }
}

internal extension Array {

    internal func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

internal extension Array {

    internal func sequentialPairs() -> Zip2Sequence<Array, Array> {
        let items = self
        var pairItems = items.shifted(by: 1)

        pairItems.removeLast()

        return zip(items, pairItems)
    }
}

import Foundation

internal struct Loop<Element>: Sequence, IteratorProtocol {

    private let array: [Element]
    private var nextIndex: Int = 0

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        array = Array(sequence)
    }

    public subscript(index: Int) -> Element {
        if index > array.count {
            return array[index % array.count]
        } else if index < 0 {
            if labs(index) >= array.count {
                return self[index + array.count]
            } else {
                return array[array.count + index]
            }
        } else {
            return array[index % array.count]
        }
    }

    public var count: Int {
        return array.count
    }

    public mutating func next() -> Element? {
        if nextIndex >= array.count {
            nextIndex = nextIndex % array.count
        }
        return array[nextIndex + 1]
    }
}

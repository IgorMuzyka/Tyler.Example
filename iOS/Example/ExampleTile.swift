
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

func test() {

    let iv = UIImageView(frame: .zero)

//    iv.contentMode
}

import Style
import Variable
import Substitutes

public enum UIImageViewStyle: Style {//: Style {

    case image(Variable<Image?>)
    case highlightedImage(Variable<Image?>)
    case isHighlighted(Variable<Bool>)

    private enum CodingKeys: String, CodingKey {
        case image
        case highlightedImage
        case isHighlighted
    }

    public enum UIImageViewStyleCodingError: Error {
        case decoding(String)
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? values.decode(Variable<Image?>.self, forKey: .image) {
            self = .image(value)
        } else if let value = try? values.decode(Variable<Image?>.self, forKey: .highlightedImage) {
            self = .highlightedImage(value)
        } else if let value = try? values.decode(Variable<Bool>.self, forKey: .isHighlighted) {
            self = .isHighlighted(value)
        } else {
            throw UIImageViewStyleCodingError.decoding("\(dump(values))")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .image(let value): try container.encode(value, forKey: .image)
        case .highlightedImage(let value): try container.encode(value, forKey: .highlightedImage)
        case .isHighlighted(let value): try container.encode(value, forKey: .isHighlighted)
        }
    }
}

extension Stylable {

    @discardableResult
    public func style(_ style: UIImageViewStyle, tags: [Tag] = []) -> Self {
        return self.style(style: style, tags: tags)
    }
}

#if os(iOS) || os(tvOS)
import UIKit

open class UIViewStylist: GenericStylist {

    public static var keyPath: AnyKeyPath?

    public required init() {}

    public func style(stylable view: UIView, style: UIViewStyle, tags: [Tag], pair: VariableResolutionPair) throws {
        switch style {
        case .isUserInteractionEnabled(let value): view.isUserInteractionEnabled = try value.resolve(pair)
        case .translatesAutoresizingMaskIntoConstraints(let value): view.translatesAutoresizingMaskIntoConstraints = try value.resolve(pair)
        case .backgroundColor(let value): view.backgroundColor = try value.resolve(pair).native
        case .tintColor(let value): view.tintColor = try value.resolve(pair).native
        case .tintAdjustmentMode(let value): view.tintAdjustmentMode = try value.resolve(pair).native!
        case .isMultipleTouchEnabled(let value): view.isMultipleTouchEnabled = try value.resolve(pair)
        case .isExclusiveTouch(let value): view.isExclusiveTouch = try value.resolve(pair)
        case .clipsToBounds(let value): view.clipsToBounds = try value.resolve(pair)
        case .alpha(let value): view.alpha = try value.resolve(pair).native
        case .isOpaque(let value): view.isOpaque = try value.resolve(pair)
        case .clearsContextBeforeDrawing(let value): view.clearsContextBeforeDrawing = try value.resolve(pair)
        case .isHidden(let value): view.isHidden = try value.resolve(pair)
        case .contentMode(let value): view.contentMode = try value.resolve(pair).native!
        }
    }
}

#endif

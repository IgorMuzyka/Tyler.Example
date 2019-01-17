
import Tyler
import TylerSupportAppleUIKit
import Variable
import Substitutes

final public class Label: Tile {

    public init(name: String? = nil, text: Variable<String>, color: Variable<Color> = .var(name: "textColor")) {
        super.init(UIKitViewType.label.rawValue, name: name, tiles: [])
        style(.textColor(color))
        style(.text(text))
    }

    public convenience init(name: String? = nil, attributedText: Variable<AttributedString>) {
        self.init(name: name, text: .let(""))
        style(.attributedText(attributedText))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

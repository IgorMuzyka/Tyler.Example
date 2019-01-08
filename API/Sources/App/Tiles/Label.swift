
import Tyler
import TylerSupportAppleUIKit
import Variable
import Substitutes

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

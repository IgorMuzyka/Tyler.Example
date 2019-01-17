
import Tyler
import Variable
import Action
import TylerSupportAppleUIKit
import Substitutes

public class Button: Tile {

    public init(name: String? = nil, text: Variable<String>, action: Action? = nil) {
        super.init(UIKitViewType.button.rawValue, name: name)

        style(.buttonTitleColor(.let(.white), .let(.normal)))
        style(.buttonTitle(text, .let(.normal)))

        if let action = action { self.action(action) }
    }

    public convenience init(name: String? = nil, attributedText: Variable<AttributedString>, action: Action? = nil) {
        self.init(name: name, text: .let(""), action: action)
        style(UIButtonStyle.buttonAttributedTitle(attributedText, .let(.normal)))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

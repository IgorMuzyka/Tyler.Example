
import TylerSupportAppleUIKit
import Tyler
import SharedTiles
import Substitutes

public class IconLabel: CenteredLabel {

	public init(name: String? = nil, icon: Icon, color: Color = .black, size: Double = 23) {
		super.init(name: name, text: .let(""))

		label.style(.attributedText(.let(icon.attributed(color: color, size: size))))
	}

	public required init(from decoder: Decoder) throws {
		try super.init(from: decoder)
	}
}


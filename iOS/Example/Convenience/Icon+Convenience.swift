
import Substitutes

extension Icon {

	public func attributed(color: Color = .black, size: Double = 23) -> AttributedString {
		return text!
			.attributed()
			.add(.foregroundColor(color))
			.add(.font(Font(name: fontName(), size: Number(size))))
	}
}

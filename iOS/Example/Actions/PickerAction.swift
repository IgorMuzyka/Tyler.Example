
import Action
import TypePreservingCodingAdapter
import Identifier

public struct PickerAction: Action {

	public static var alias: Alias = "PickerAction"

	public enum ActionType: IntegerLiteralType, Codable {
		case left, right
	}

	public let ownerId: Identifier
	public let type: ActionType
	public let offset: Double

	public init(ownerId: Identifier, type: ActionType, offset: Double) {
		self.ownerId = ownerId
		self.type = type
		self.offset = offset
	}

	public static func execute(action: PickerAction) {
		guard
			let delegate = UIApplication.shared.delegate as? AppDelegate,
			let themeScreen = delegate.window?.rootViewController as? TileViewController,
			let scrollView = themeScreen.context.find(where: { $0.id == action.ownerId })?.view as? UIScrollView
			else { return }

		let direction: CGFloat = (action.type == .left) ? -1 : +1
		let offset = direction * CGFloat(action.offset)
		let newOffset = scrollView.contentOffset.x + offset
		let minmaxedOffset = max(min(newOffset, scrollView.contentSize.width), 0)

		UIView.animate(withDuration: 0.3, animations: {
			scrollView.contentOffset.x = minmaxedOffset
		})
	}
}


import Tyler
import TylerSupportAppleUIKit
import SharedTiles
import Substitutes
import Anchor

public class Picker: Tile {

	public init(title pickerTitle: String, items: [Tile], pageWidth: Double) {
		let title = Label(text: .let(pickerTitle))
		let pageView = PageView(pages: items, orientation: .horizontal)
		let left = Button(
			attributedText: .let(Icon.fontAwesome(.caretLeft).attributed(color: .black, size: 23)),
			action: PickerAction(ownerId: pageView.id, type: .left, offset: pageWidth)
		)
		let right = Button(
			attributedText: .let(Icon.fontAwesome(.caretRight).attributed(color: .black, size: 23)),
			action: PickerAction(ownerId: pageView.id, type: .right, offset: pageWidth)
		)

		super.init(UIKitViewType.view.rawValue, tiles: [title, left, pageView, right])

		anchors([
			title.anchor.centerY.top.bottom,
			pageView.anchor.centerY.top.bottom,
			left.anchor.centerY.top.bottom,
			right.anchor.centerY.top.bottom,

			title.anchor.left.constant(10),

			left.anchor.left.to(title.anchor.right),

			left.anchor.right.to(pageView.anchor.left).constant(-10),
			pageView.anchor.right.to(right.anchor.left).constant(-10),
			right.anchor.right.constant(-10),

			left.anchor.width.equal.to(20),
			pageView.anchor.width.equal.to(pageWidth),
			right.anchor.width.equal.to(left.anchor.width),
		])

		pageView.style(.clipsToBounds(.let(true)))
	}

	required init(from decoder: Decoder) throws {
		fatalError("init(from:) has not been implemented")
	}
}


import Tyler
import Anchor
import Action
import Substitutes
import TylerSupportAppleUIKit
import TylerSupportAppleCommon
import SharedTiles

enum ThemeScreen {

	static func screen() -> Tile {
		let colors: [Color] = [.black, .darkGray, .lightGray, .white, .gray, .red, .green, .blue, .cyan, .yellow, .magenta, .orange, .purple, .brown]

		let colorPicker = Picker(title: "Color", items: colors.map { color in
			Tile(UIKitViewType.view)
				.style(UIViewStyle.backgroundColor(.let(color)))
				.style(.borderWidth(.let(1)))
				.style(.borderColor(.let(.black)))
		}, pageWidth: 20)

		colorPicker.anchors([
			colorPicker.anchor.left.top.right,
			colorPicker.anchor.height.equal.to(20)
		])

		return Screen(tile: colorPicker)
	}

}

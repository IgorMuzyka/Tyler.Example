
import Tyler
import TylerSupportAppleUIKit
import TylerSupportAppleCommon
import Variable
import Anchor

final public class RandomUserTile: Tile {

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

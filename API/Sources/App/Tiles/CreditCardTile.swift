
import Tyler
import TylerSupportAppleUIKit
import Variable
import Anchor

final public class CreditCardTile: Tile {

    init(name: String? = nil, creditCard: RandomUser.CreditCard) {
        let number = Label(text: .let(creditCard.number))
        let expiration = Label(text: .let(creditCard.expiration))

        number.anchors([
            number.anchor.top.left.right.equal.to(20)
            ])

        super.init(UIKitViewType.view.rawValue, tiles: [number, expiration])

        anchor(Anchor(.self).width.equal.to(Anchor(.self).height).multiplier(1/3))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

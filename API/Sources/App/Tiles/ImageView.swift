
import Tyler
import TylerSupportAppleUIKit
import TylerSupportAppleCommon
import Substitutes


final public class ImageView: Tile {

    init(url: String) {
        super.init(UIKitViewType.imageView.rawValue, tiles: [])
        style(UIImageViewStyle.url(.let(url)))
        style(UIViewStyle.contentMode(.let(.scaleAspectFit)))
        style(UIViewStyle.backgroundColor(.let(.green)))
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
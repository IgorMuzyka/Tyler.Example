

import Vapor
import TylerSupportAppleUIKit
import Anchor
import SharedTiles

extension ScrollView: Content {}

final class UserController {

    static func randomUsers(_ request: Request) throws -> Future<ScrollView> {
        return try request.client().get("https://uinames.com/api/?amount=15&region=england&ext").flatMap { response in
            return try response.content.decode([RandomUser].self).flatMap { users in
                let items = users.map {
                    RandomUserTile(user: $0)
                        .style(UIViewStyle.backgroundColor(.let(.random)))
                }

                let scrollView = ScrollView(items: items, orientation: .vertical)
                    .anchor(Anchor(.self).left.bottom.right)
                    .anchor(Anchor(.self).topMargin.constant(50))
                    .style(UIViewStyle.backgroundColor(.let(.white)))

                EqualSizeFixedSpacingLayout.layout(tiles: items, in: scrollView.contentView, with: 10, orientation: .vertical)

                return Future.map(on: request) { scrollView }
            }
        }
    }
}

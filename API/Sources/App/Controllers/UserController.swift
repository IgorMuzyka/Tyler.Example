

import Vapor
import TylerSupportAppleUIKit
import Anchor

final class UserController {

    static func randomUsers(_ request: Request) throws -> Future<PageView> {
        return try request.client().get("https://uinames.com/api/?amount=20&region=england&ext").flatMap { response in
            return try response.content.decode([RandomUser].self).flatMap { users in
                return request.future(
                    PageView(pages: users.map { user in
                        return RandomUserTile(user: user)
                            .style(UIViewStyle.backgroundColor(.let(.random)))
                    }, orientation: .horizontal)
                        .anchor(Anchor(.self).top.left.bottom.right)
                )
            }
        }
    }
}

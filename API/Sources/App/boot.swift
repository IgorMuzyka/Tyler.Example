
import Vapor
import Tyler
import TylerSupportAppleUIKit

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    Tyler.adapter.registerUIKitSupportStyles()
    Tyler.adapter.register(action: NavigationAction.self)
}

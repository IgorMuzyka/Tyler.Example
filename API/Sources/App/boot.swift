
import Vapor
import TypePreservingCodingAdapter
import Tyler
import TylerSupportAppleUIKit

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // your code here
    Tyler.adapter.registerUIKitSupportStyles()
    
    Tyler.adapter.register(type: NavigationAction.self)
    Tyler.adapter.register(alias: NavigationAction.alias, for: NavigationAction.self)
}

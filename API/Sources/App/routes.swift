
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get("users", use: UserController.randomUsers)
}


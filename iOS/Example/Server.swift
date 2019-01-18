
import Foundation

enum Server {

    static var port = "8080"
    static var ipAddress: String = {
        return Bundle.main.infoDictionary?["REMOTE_IP_ADDRESS"] as! String
    }()

    static func route(to path: String) -> URL {
        let route = "http://\(ipAddress):\(port)/\(path)"
        return URL(string: route)!
    }
}

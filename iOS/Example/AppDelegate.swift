//
//  AppDelegate.swift
//  Example
//
//  Created by Igor Myzyka on 11/29/18.
//  Copyright © 2018 Igor Myzyka. All rights reserved.
//

import UIKit
import Tyler
import TylerSupportAppleUIKit
import Action
//import Variable
//import Substitutes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tyler = Tyler(factory: .defaultUIKit, stylists: .defaultUIKit)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        Tyler.adapter.registerUIKitSupportStyles()
        Tyler.adapter.register(type: NavigationAction.self)
        Tyler.adapter.register(alias: NavigationAction.alias, for: NavigationAction.self)

        tyler.stores.actionHandlers.add { [weak self] (action: NavigationAction) in
            guard let `self` = self else { return }

            let tile = RemoteTile(url: Server.route(to: action.destination))
            self.window!.rootViewController = RemoteTileViewController(remoteTile: tile, tyler: self.tyler)

            print(action.destination)
        }

        window!.rootViewController = RemoteTileViewController(remoteTile: RemoteTile(url: Server.route(to: "todos")), tyler: tyler)
        window!.makeKeyAndVisible()

        return true
    }
}

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

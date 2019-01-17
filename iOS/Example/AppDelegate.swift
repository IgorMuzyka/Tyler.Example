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

        let ipAddress = Bundle.main.infoDictionary?["REMOTE_IP_ADDRESS"] as! String
        let port = "8080"

        let route = "http://\(ipAddress):\(port)/todos"
        let url = URL(string: route)!

        tyler.stores.actionHandlers.add { (action: NavigationAction) in
            print(action.destination)
        }

        window!.rootViewController = RemoteTileViewController(remoteTile: RemoteTile(url: url), tyler: tyler)



        
//        window!.rootViewController = RemoteTileViewController(remoteTile: RemoteTile(url: url), tyler: tyler)
//            TileViewController(tile: ExampleTile(), tyler: tyler)
        window!.makeKeyAndVisible()

        return true
    }
}

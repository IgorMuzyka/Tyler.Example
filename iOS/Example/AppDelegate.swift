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
import Variable
//import Substitutes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    let tyler = Tyler(factory: .defaultUIKit, stylists: .defaultUIKit)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        Tyler.adapter.registerUIKitSupportStyles()
//		Tyler.adapter.register(action: NavigationAction.self)

//        tyler.stores.actionHandlers.add { [weak self] (action: NavigationAction) in
//            guard let `self` = self else { return }
//
//            let tile = RemoteTile(url: Server.route(to: action.destination))
//            self.window!.rootViewController = RemoteTileViewController(remoteTile: tile, tyler: self.tyler)
//
//            print(action.destination)
//        }
//
        tyler.stores.variableResolvers.register(name: "statusBar.height") { () -> Variable<Double> in
            return .let(Double(UIApplication.shared.statusBarFrame.height))
        }

		Tyler.adapter.register(action: PickerAction.self)

		tyler.stores.actionHandlers.add(PickerAction.execute)

		window!.rootViewController = TileViewController(tile: ThemeScreen.screen(), tyler: tyler)

//        window!.rootViewController = RemoteTileViewController(remoteTile: RemoteTile(url: Server.route(to: "todos")), tyler: tyler)
        window!.makeKeyAndVisible()

        return true
    }
}

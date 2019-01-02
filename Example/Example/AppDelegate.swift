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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let tyler = Tyler(factory: .defaultUIKit, stylists: .defaultUIKit, stylesSerializers: .defaultUIKit)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window!.rootViewController = TileViewController(tile: ExampleTile(), tyler: tyler)
        window!.makeKeyAndVisible()

        return true
    }
}


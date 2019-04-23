//
//  AppDelegate.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import RSReactiveRequest

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initialSetup()
        StyleBuilder.initialize()
        return true
    }

}

extension AppDelegate {
    
    func initialSetup() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootRouter: RootRouter?
        rootRouter = RootRouter.init(window: window!)
        rootRouter!.installViewIntoRootViewController()
        window?.makeKeyAndVisible()
    }
        
}

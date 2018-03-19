//
//  AppDelegate.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupGeneralAppearences()
        
        return true
    }
    
    func setupGeneralAppearences() {
        UITabBar.appearance().tintColor = UIColor(red: 99.0/255.0, green: 66.0/255.0, blue: 140/255.0, alpha: 1.0)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}


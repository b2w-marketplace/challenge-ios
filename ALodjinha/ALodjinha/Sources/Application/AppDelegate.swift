//
//  AppDelegate.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 15/08/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        UIWindow()
    }()
    
    private lazy var rootViewController: AppCoordinator = {
        guard let window = self.window else { fatalError("Falied to create window") }
        let appCoordinator = AppCoordinator(window: window)
        return appCoordinator
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootViewController.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}


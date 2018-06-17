//
//  AppDelegate.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 14/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        RootNavigationViewControllerFactory.make(window: window!).root()
    }

}


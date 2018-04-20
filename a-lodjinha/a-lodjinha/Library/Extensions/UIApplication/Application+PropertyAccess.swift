//
//  Application+PropertyAccess.swift
//  TopGamesPAN
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

/**
 UIApplication extesion providing smart access to default properties
 */
extension UIApplication {
    
    var appVersion: String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return ""
        }
        
        return version
    }
    
    /**
     It returns the default application window if it exists
     */
    func getWindow() -> UIWindow? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        guard let window = appDelegate.window else {
            return nil
        }
        
        return window
    }
    
}

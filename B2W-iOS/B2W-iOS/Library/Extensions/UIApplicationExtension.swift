//
//  UIApplicationExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 09/04/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UIApplication {
    
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

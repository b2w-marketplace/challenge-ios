//
//  UIWindow+SetRoot.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func set(rootViewController newRootViewController: UIViewController) {
        
        let previousViewController = rootViewController
        
        rootViewController = newRootViewController
        newRootViewController.setNeedsStatusBarAppearanceUpdate()
        
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        
        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}

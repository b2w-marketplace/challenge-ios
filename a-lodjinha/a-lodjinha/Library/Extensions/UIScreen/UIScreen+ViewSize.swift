//
//  UIScreen+ViewSize.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

extension UIScreen {
    
    func isSmallScreen() -> Bool {
        return UIScreen.main.bounds.height <= 568.0
    }
    
}

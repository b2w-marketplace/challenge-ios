//
//  Constants+FontSize.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

/**
 Constants related to the font size
 */
extension Constants {
    
    struct FontSize {
        static let ExtraSmall: CGFloat = UIScreen.main.isSmallScreen() ? 9.0 : 12.0
        static let Small: CGFloat = UIScreen.main.isSmallScreen() ? 12.0 : 15.0
        static let Normal: CGFloat = UIScreen.main.isSmallScreen() ? 15.0 : 18.0
        static let Big: CGFloat = UIScreen.main.isSmallScreen() ? 18.0 : 21.0
        static let ExtraBig: CGFloat = UIScreen.main.isSmallScreen() ? 21.0 : 24.0
    }
    
}

//
//  UIFont+FontWeight.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

/**
 UIFont extension to provide a wrapper for Fonts weight customization
 */
extension UIFont {
    
    /**
     An enum for Font Weight separated from iOS version.
     */
    enum FontWeight {
        case regular
    }
    
    /**
     It creates a font for the given Font Weight and Font Size.
     */
    static func setFont(fontWeight: FontWeight, fontSize: CGFloat) -> UIFont {
        let font: UIFont
        
        switch fontWeight {
            
        case .regular:
            font = UIFont(name: "Pacifico-Regular", size: fontSize)!
            
            break;
        
        }
        
        
        return font
        
    }
    
}

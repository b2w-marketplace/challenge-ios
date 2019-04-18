//
//  UIColor+Hex.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString:String) {
        let hexStringValue = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        let scanner   = Scanner(string: hexStringValue)
        
        if (hexStringValue.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    convenience init(hexStringWithAlpha:String) {
        let hexStringValue = hexStringWithAlpha.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        let scanner   = Scanner(string: hexStringValue)
        
        if (hexStringValue.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 24) & mask
        let g = Int(color >> 16) & mask
        let b = Int(color >> 8) & mask
        let a = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
}

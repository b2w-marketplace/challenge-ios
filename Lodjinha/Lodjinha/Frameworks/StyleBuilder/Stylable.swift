//
//  Stylable.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

protocol Stylable {
    
    var frame: CGRect { get }
    
    func applyBackgroundColor(_ color: UIColor)
    func applyCornerRadius(_ radius: CGFloat)
    func applyBorderColor(_ color: UIColor)
    func applyBorderWidth(_ width: CGFloat)
    func applyShadowRadius(_ radius: CGFloat)
    func applyShadowOpacity(_ opacity: Float)
    func applyMasksToBounds(_ masksToBounds: Bool)
    func applyShadowColor(_ color: UIColor)
    func applyShadowOffset(_ offset: CGSize)
    
}

extension UIView: Stylable {
    
    func applyBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func applyCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func applyBorderColor(_ color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    func applyBorderWidth(_ width: CGFloat) {
        layer.borderWidth = width
    }
    
    func applyShadowRadius(_ radius: CGFloat) {
        layer.shadowRadius = radius
    }
    
    func applyShadowOpacity(_ opacity: Float) {
        layer.shadowOpacity = opacity
    }
    
    func applyMasksToBounds(_ masksToBounds: Bool) {
        layer.masksToBounds = masksToBounds
    }
    
    func applyShadowColor(_ color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: .allCorners,
                                        cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
    
    func applyShadowOffset(_ offset: CGSize) {
        layer.shadowOffset = offset
    }
    
}

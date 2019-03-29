//
//  CustomDisclosureIndicator.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

@IBDesignable
class CustomDisclosureIndicator: UIView {
    @IBInspectable var color = UIColor.purple {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 4
        let y = self.bounds.midY
        let R = CGFloat(2.5)
        context?.move(to: CGPoint(x: x - R*2, y: y - R*2))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R*2, y: y + R*2))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(2)
        color.setStroke()
        context?.strokePath()
    }
}

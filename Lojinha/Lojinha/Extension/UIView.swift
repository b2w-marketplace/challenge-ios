//
//  UIView.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

extension UIView
{
    func cornerRadius(radius: CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    
    func circleView()
    {
        let halfWidth = self.layer.frame.size.width/2
        cornerRadius(radius: halfWidth)
    }
}

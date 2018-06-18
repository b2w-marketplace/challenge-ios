//
//  UIView.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 17/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1
    }
}

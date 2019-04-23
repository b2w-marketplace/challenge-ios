//
//  RawRepresentable+Color.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension RawRepresentable where Self.RawValue == String {
    
    var color: UIColor {
        return UIColor(hexString: rawValue)
    }
    
    func colorWithAlpha(alpha: CGFloat) -> UIColor {
        return color.withAlphaComponent(alpha)
    }
    
}

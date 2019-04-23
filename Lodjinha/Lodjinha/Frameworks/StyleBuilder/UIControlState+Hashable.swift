//
//  UIControlState+Hashable.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension UIControlState: Hashable {
    
    public var hashValue: Int {
        return Int(rawValue)
    }
    
}

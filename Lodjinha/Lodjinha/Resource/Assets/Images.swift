//
//  Images.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    enum Identifier: String {
        case homeActive
        case homeDeselected
        case tagSelected
        case tagDeselected
        case logoNavbar
        case placeholder
    }
    
    convenience init?(identifier: Identifier) {
        self.init(named: identifier.rawValue)
    }
    
}

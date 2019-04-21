//
//  Strings.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

extension String {
    
    enum Identifier: String {
        
        // MARK: - Common
        case home
        case about
        case theLodjinha
        case devName
        case serviceErrorMessage
        case buttonOk
        case titleAlert
        case categories
        case topSelling
        case from
        case to

        
    }
    
    init(identifier: Identifier, comment: String = String()) {
        self.init(stringLiteral: NSLocalizedString(identifier.rawValue, comment: comment))
    }
    
    init(identifier: Identifier, count: Int, comment: String = String()) {
        let format = NSLocalizedString(identifier.rawValue, comment: String())
        self.init(format: format, count)
    }
    
}

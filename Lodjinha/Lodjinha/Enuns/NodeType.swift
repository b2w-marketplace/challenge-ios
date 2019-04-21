//
//  NodeType.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

enum NodeType: String {
    
    case banner
    case category
    case product
    
}

extension NodeType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .banner:
            return String()
            
        case .category:
            return String(identifier: .categories)
            
        case .product:
            return String(identifier: .topSelling)
        }
    }
    
}

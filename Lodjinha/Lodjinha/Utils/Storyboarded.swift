//
//  Storyboarded.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
}

extension Storyboarded {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName)
    }
}

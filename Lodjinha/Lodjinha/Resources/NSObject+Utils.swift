//
//  NSObject+Utils.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 27/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

extension NSObject {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
}

//
//  Float+Currency.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

extension Float {
    
    func currency(by numberFormatter: NumberFormatter) -> String {
        return numberFormatter.string(from: NSNumber(value: self)) ?? String()
    }
    
}

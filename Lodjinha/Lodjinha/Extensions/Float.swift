//
//  Float.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import UIKit

extension Float {
    var asLocaleCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")
        
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}

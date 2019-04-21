//
//  NumberFormatter+CurrencyPtBr.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

enum CurrencySymbol {
    static var real: String = "R$";
}

extension NumberFormatter {
    
    static var currencyPtBr: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.currencySymbol = CurrencySymbol.real
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale(identifier: "pt-BR")
        return formatter
    }
    
}

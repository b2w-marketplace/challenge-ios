//
//  String+Extensions.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

extension Double {
    
    func formatCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: NSNumber(value: self)) {
            return formattedTipAmount
        } else { return "\(self)" }
    }
    
    func setupAttribuites() -> NSMutableAttributedString {
         let value: String = self.formatCurrency()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: value)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}




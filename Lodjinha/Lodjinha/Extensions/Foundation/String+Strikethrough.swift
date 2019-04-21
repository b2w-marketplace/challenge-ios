//
//  NSMutableAttributedString+Strikethrough.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var strikethrough: NSMutableAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                     value: NSUnderlineStyle.styleSingle.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
}

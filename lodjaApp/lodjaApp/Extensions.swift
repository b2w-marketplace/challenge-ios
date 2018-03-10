//
//  Extensions.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

extension UILabel {
    func setScratchedText(_ text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString;
    }
}

extension UIColor {
    static func purpleB2W() -> UIColor {
        return UIColor(red: 96.0/256, green: 44.0/256, blue: 127.0/256, alpha: 1)
    }
    
}

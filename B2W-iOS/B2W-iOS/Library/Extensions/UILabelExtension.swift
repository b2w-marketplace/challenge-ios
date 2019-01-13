//
//  UILabelExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UILabel {
    
    var html: String? {
        set {
            guard let h = newValue, let att = h.htmlAttributedString else {
                self.text = nil
                return
            }
            
            let range: NSRange = NSString(string: att.string).range(of: att.string)
            att.addAttribute(.foregroundColor, value: textColor, range: range)
            att.addAttribute(.font, value: font, range: range)
            
            self.attributedText = att
        }
        get { return self.attributedText?.string }
    }
}

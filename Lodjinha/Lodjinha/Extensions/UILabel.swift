//
//  UILabel.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 17/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StrikeLabel: UILabel {
    
    func setup() {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        let textRange = NSMakeRange(0, self.text!.count)
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                      value: NSUnderlineStyle.styleSingle.rawValue,
                                      range: textRange)
        self.attributedText = attributedString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

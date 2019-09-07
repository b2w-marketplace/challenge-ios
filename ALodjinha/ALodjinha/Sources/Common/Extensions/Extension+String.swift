//
//  Extension+String.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

extension String {
    func makeStrikeThroughText(_ text: String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: 1,
                                     range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
}

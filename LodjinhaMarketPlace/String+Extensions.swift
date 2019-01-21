//
//  String+Extensions.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    public typealias Attributes = [NSAttributedString.Key: Any]
    
    /**
     Interprets `self` as an HTML string to produce an attributed string.
     - parameter base:   The base attributes to use for the attributed string.
     - parameter bold:   Optional attributes to use on bold tags. If not specified it will be derived
     from `font`.
     - parameter italic: Optional attributes for use on italic tags. If not specified it will be derived
     from `font`.
     - returns: The attributed string, or `nil` if something goes wrong with interpreting the string
     as html.
     */
    public func simpleHtmlAttributedString(base: Attributes, bold optionalBold: Attributes? = nil, italic optionalItalic: Attributes? = nil) -> NSAttributedString? {
        
        // let baseFont = (base[NSAttributedString.Key.font] as? UIFont) ?? UIFont.systemFont(ofSize: 16.0)
        
        // If bold or italic are not specified we can derive them from `font`.
        let bold = optionalBold ?? [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let italic = optionalItalic ?? [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]
        
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let string = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        
        // Sub all bold and italic fonts in the attributed html string
        let stringRange = NSRange(location: 0, length: string.length)
        string.beginEditing()
        string.enumerateAttribute(NSAttributedString.Key.font, in: stringRange, options: []) { value, range, _ in
            
            guard let htmlFont = value as? UIFont else { return }
            let newAttributes: Attributes
            
            if htmlFont.fontDescriptor.symbolicTraits.contains(.traitBold) {
                newAttributes = bold
            } else if htmlFont.fontDescriptor.symbolicTraits.contains(.traitItalic) {
                newAttributes = italic
            } else {
                newAttributes = base
            }
            
            string.addAttributes(newAttributes, range: range)
        }
        string.endEditing()
        
        return string
    }
}

//
//  String+Html2String.swift
//  Lodjinha
//
//  Created by Marcos on 23/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension String {
        
    func html2AttributedString(font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil) -> NSAttributedString? {
        do {
            let attributedString = try NSMutableAttributedString(data: Data(utf8),
                                                                 options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                                 documentAttributes: nil)
            
            if let attributes = makeCustomAttributes(font: font, textColor: textColor, textAlignment: textAlignment) {
                attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.string.count))
            }
            
            return attributedString
        } catch {
            print("Error: Failed to convert HTML to AttributtedString", error)
            return nil
        }
    }
    
    private func makeCustomAttributes(font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil) -> [NSAttributedStringKey: Any]? {
        var attributes: [NSAttributedStringKey: Any] = [:]
        
        if let font = font {
            attributes[.font] = font
        }
        
        if let color = textColor {
            attributes[.foregroundColor] = color
        }
        
        if let alignment = textAlignment {
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = alignment
            attributes[.paragraphStyle] = textStyle
        }
        
        return attributes.keys.isNotEmpty ? attributes : nil
    }
    
    var html2String: String {
        return html2AttributedString()?.string ?? String()
    }
    
}

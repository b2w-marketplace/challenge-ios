//
//  StringExtension.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

extension String{
    func convertHtml(_ font: String? = nil, _ size: Double? = nil) -> NSAttributedString {
        var modifiedFont: String

        if let font = font, let `size` = size {
            modifiedFont = String(format:"<span style=\"font-family: '\(font)', 'HelveticaNeue'; font-size: \(size)\">%@</span>", self)
        } else {
            modifiedFont = self
        }

        do {
            return try NSAttributedString(data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue]
                ,
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return NSAttributedString()
        }
    }
}

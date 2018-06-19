//
//  StringUtils.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation

extension String{
    
    func convertHtml() -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return nil
        }
    }
}

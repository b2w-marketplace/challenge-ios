//
//  StringExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

extension String {
    var htmlAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else {
            return NSMutableAttributedString()
        }
        
        do {
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
    
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
}

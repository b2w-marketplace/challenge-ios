//
//  String.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 16/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

extension String
{
//    func convertHtml() -> NSAttributedString?
//    {
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do
//        {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        }
//        catch
//        {
//            return nil
//        }
//    }
    
    var html2AttributedString: NSAttributedString?
    {
        do
        {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        }
        catch
        {
            print("error: ", error)
            return nil
        }
    }
    
    var html2String: String
    {
        return html2AttributedString?.string ?? ""
    }
    
    
    func textMiddleLine() -> NSAttributedString
    {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1.5, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
}

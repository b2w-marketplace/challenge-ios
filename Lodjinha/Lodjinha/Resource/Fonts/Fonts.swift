//
//  Fonts.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    enum Style: String {
        case regular = "Regular"
    }
    
    static private func pacificoFontName(style: Style) -> String {
        return "Pacifico-\(style.rawValue)"
    }
    
    static func pacifico(style: Style, size: CGFloat) -> UIFont {
        let fontName = pacificoFontName(style: style)
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
    
}

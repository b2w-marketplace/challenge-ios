//
//  Fonts.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

struct Font {
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }

    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }

    enum FontName: String {
        case RobotoBold = "Roboto-Bold"
        case RobotoLight = "Roboto-Light"
        case RobotoMedium = "Roboto-Medium"
        case RobotoRegular = "Roboto-Regular"
        case PacificoRegular = "Pacifico-Regular"
    }

    enum StandardSize: Double {
        case logo = 64.0
        case logoMenu = 24.0
        case title = 20.0
        case descriptionLarge = 18.0
        case descriptionSmall = 17.0
        case menuItem = 14.0
        case category = 13.0
        case subtitle = 12.0
    }

    var type: FontType
    var size: FontSize

    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    var instance: UIFont {
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

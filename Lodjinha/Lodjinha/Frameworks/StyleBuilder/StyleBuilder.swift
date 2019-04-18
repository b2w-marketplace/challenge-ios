//
//  StyleBuilder.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

var Style: StyleBuilder {
    return StyleBuilder()
}

final class StyleBuilder {
    
    private var font: UIFont?
    private var backgroundColor: UIColor?
    private var cornerRadius: CGFloat?
    private var borderColor: UIColor?
    private var borderWidth: CGFloat?
    private var textAlignment: NSTextAlignment?
    private var textColorMap: [UIControlState: UIColor] = [:]
    private var shadowRadius: CGFloat?
    private var shadowOpacity: Float?
    private var masksToBounds: Bool?
    private var shadowColor: UIColor?
    private var shadowOffset: CGSize?
    
    fileprivate init() {
        
    }
    
    func withBackgroundColor(_ color: UIColor) -> StyleBuilder {
        backgroundColor = color
        return self
    }
    
    func withCornerRadius(_ radius: CGFloat) -> StyleBuilder {
        cornerRadius = radius
        return self
    }
    
    func withBorderColor(_ color: UIColor) -> StyleBuilder {
        borderColor = color
        return self
    }
    
    func withBorderWidth(_ width: CGFloat) -> StyleBuilder {
        borderWidth = width
        return self
    }
    
    func withFont(_ font: UIFont) -> StyleBuilder {
        self.font = font
        return self
    }
    
    func withTextColor(_ color: UIColor, for state: UIControlState = .normal) -> StyleBuilder {
        textColorMap[state] = color
        return self
    }
    
    func withTextAlignment(_ alignment: NSTextAlignment) -> StyleBuilder {
        textAlignment = alignment
        return self
    }
    
    func withShadowRadius(_ radius: CGFloat) -> StyleBuilder {
        shadowRadius = radius
        return self
    }
    
    func withShadowOpacity(_ opacity: Float) -> StyleBuilder {
        shadowOpacity = opacity
        return self
    }
    
    func withMasksToBounds(_ isMasksToBounds: Bool) -> StyleBuilder {
        masksToBounds = isMasksToBounds
        return self
    }
    
    func withShadowColor(_ color: UIColor) -> StyleBuilder {
        shadowColor = color
        return self
    }
    
    func withShadowOffset(_ offset: CGSize) -> StyleBuilder {
        shadowOffset = offset
        return self
    }
    
    // MARK: - Condensed Functions
    func border(color: UIColor, width: CGFloat, radius: CGFloat) -> StyleBuilder {
        borderColor = color
        borderWidth = width
        cornerRadius = radius
        return self
    }
    
    func text(font: UIFont, color: UIColor, alignment: NSTextAlignment) -> StyleBuilder {
        self.font = font
        textColorMap[.normal] = color
        textAlignment = alignment
        return self
    }
    
    // MARK: - Apply functions
    func apply(onTextStylable element: TextStylable?) {
        apply(onTextStylables: [element])
    }
    
    func apply(onTextStylables elements: [TextStylable?]) {
        elements.compactMap{ $0 }
            .forEach {
                setFont(stylable: $0)
                setTextColor(stylable: $0)
                setTextAlignment(stylable: $0)
        }
    }
    
    func apply(on element: Stylable?) {
        apply(on: [element])
    }
    
    func apply(on elements: [Stylable?]) {
        elements.compactMap{ $0 }
            .forEach {
                setBackgroundColor(stylable: $0)
                setCornerRadius(stylable: $0)
                setBorderColor(stylable: $0)
                setBorderWidth(stylable: $0)
                setShadowColor(stylable: $0)
                setShadowOffset(stylable: $0)
                setShadowRadius(stylable: $0)
                setShadowOpacity(stylable: $0)
                setMasksToBounds(stylable: $0)
                
                if let textStylable = $0 as? TextStylable {
                    apply(onTextStylable: textStylable)
                }
        }
    }
    
}

// MARK: - Private Methods
extension StyleBuilder {
    
    private func setBackgroundColor(stylable: Stylable) {
        if let backgroundColor = backgroundColor {
            stylable.applyBackgroundColor(backgroundColor)
        }
    }
    
    private func setCornerRadius(stylable: Stylable) {
        if let cornerRadius = cornerRadius {
            stylable.applyCornerRadius(cornerRadius)
        }
    }
    
    private func setBorderColor(stylable: Stylable) {
        if let borderColor = borderColor {
            stylable.applyBorderColor(borderColor)
        }
    }
    
    private func setBorderWidth(stylable: Stylable) {
        if let borderWidth = borderWidth {
            stylable.applyBorderWidth(borderWidth)
        }
    }
    
    private func setShadowRadius(stylable: Stylable) {
        if let shadowRadius = shadowRadius {
            stylable.applyShadowRadius(shadowRadius)
        }
    }
    
    private func setShadowOpacity(stylable: Stylable) {
        if let shadowOpacity = shadowOpacity {
            stylable.applyShadowOpacity(shadowOpacity)
        }
    }
    
    private func setMasksToBounds(stylable: Stylable) {
        if let masksToBounds = masksToBounds {
            stylable.applyMasksToBounds(masksToBounds)
        }
    }
    
    private func setShadowColor(stylable: Stylable) {
        if let shadowColor = shadowColor {
            stylable.applyShadowColor(shadowColor)
        }
    }
    
    private func setShadowOffset(stylable: Stylable) {
        if let shadowOffset = shadowOffset {
            stylable.applyShadowOffset(shadowOffset)
        }
    }
    
    private func setFont(stylable: TextStylable) {
        if let font = font {
            stylable.applyTextFont(font)
        }
    }
    
    private func setTextColor(stylable: TextStylable) {
        for (state, color) in textColorMap {
            stylable.applyTextColor(color, for: state)
        }
    }
    
    private func setTextAlignment(stylable: TextStylable) {
        if let textAlignment = textAlignment {
            stylable.applyTextAlignment(textAlignment)
        }
    }
    
}

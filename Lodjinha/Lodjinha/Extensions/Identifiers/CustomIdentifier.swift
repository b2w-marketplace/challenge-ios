//
//  CustomIdentifier.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

public protocol CustomIdentifier {
    var key: String { get }
}

extension CustomIdentifier where Self: RawRepresentable, Self.RawValue == String {
    
    public var key: String { return self.rawValue }
    
}

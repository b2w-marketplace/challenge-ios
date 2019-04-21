//
//  Extension+String.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

extension String {
    static func doubleToString(_ value: Double) -> String {
        return (String(format: "%.2f", value).replacingOccurrences(of: ".", with: ","))
    }
}

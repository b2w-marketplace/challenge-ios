//
//  Extension+Double.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

extension Double {
    func formatTwoDecimal(value: Double) -> String {
        return String(format: "%.2f", value)
    }
}

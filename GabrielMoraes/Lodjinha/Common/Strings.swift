//
//  Strings.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

struct Strings {
    
    private static func get(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    static let homeSectionBestSellers = Strings.get(key: "homeSectionBestSellers")
    static let productCellPriceOld = Strings.get(key: "productCellPriceOld")
    static let productCellPriceNew = Strings.get(key: "productCellPriceNew")
    static let errorTitle = Strings.get(key: "errorTitle")
    static let errorSerialization = Strings.get(key: "errorSerialization")
    static let errorUnexpected = Strings.get(key: "errorUnexpected")
    static let infoNoResults = Strings.get(key: "infoNoResults")
    
}

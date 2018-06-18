//
//  Constants.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 13/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    struct URLs {
        static let baseURL = "https://alodjinha.herokuapp.com"
        static let banners = "/banner"
        static let categories = "/categoria"
        static let products = "/produto"
        static let bestSeller = "/maisvendidos"
        static let reserveAndProductDetail = "/{productId}"
    }
    
    struct CellIdentifiers {
        static let category = "categoryCell"
        static let bestSeller = "bestSellerCell"
    }
    
    enum Response: Int {
        case product = 0, category, banner
        
        var type: Int {
            return self.rawValue
        }
    }
    
    struct Color {
        static let purple = UIColor(red: 87/255.0, green: 58/255.0, blue: 124/255.0, alpha: 1.0)
    }
}

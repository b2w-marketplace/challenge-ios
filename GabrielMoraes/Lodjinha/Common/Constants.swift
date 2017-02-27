//
//  Constants.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

struct Constants {
    
    static let colorDarkishPurple = UIColor(red: 90/255, green: 41/255, blue: 134/255, alpha: 0.9)
    static let colorWarmPurple = UIColor(red: 94/255, green: 42/255, blue: 132/255, alpha: 1.0)
    
    static let identifierProduct = "ProductCell"
    
    private static let urlBase = "https://alodjinha.herokuapp.com"
    static let urlProduct = urlBase + "/produto"
    static let urlBestSellers = urlProduct + "/maisvendidos"
    static let urlCategories = urlBase + "/categoria"
    static let urlBanners = urlBase + "/banner"
    
}

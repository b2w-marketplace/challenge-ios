//
//  ApiProvider.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct ApiProvider {
    
    /// banner URL
    static var bannerUrl: String {
        return "https://alodjinha.herokuapp.com/banner"
    }
    
    /// category URL
    static var categoryUrl: String {
        return "https://alodjinha.herokuapp.com/categoria"
    }
    
    /// product URL
    static var productUrl: String {
        return "https://alodjinha.herokuapp.com/produto/"
    }
    
    /// top selled products URL
    static var topSelledProductsUrl: String {
        return productUrl + "/maisvendidos"
    }
    
    static var productsOfCategoryUrl: String {
        return "https://alodjinha.herokuapp.com/produto?categoriaId="
    }
    
}

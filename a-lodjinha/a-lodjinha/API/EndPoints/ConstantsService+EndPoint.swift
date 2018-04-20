//
//  ConstantsService+EndPoint.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

extension ConstantsService {
    
    struct EndPoint {

        struct Banner {
            fileprivate static let Banner = "/banner"
        }
        
        struct Category {
            fileprivate static let Category = "/categoria"
        }
        
        struct Product {
            fileprivate static let ProductByCategory = "/produto?categoriaId=%i"
            fileprivate static let ProductBestSeller = "/produto/maisvendidos"
            fileprivate static let ProductById = "/produto/%i"
        }
        
        static let Lodjinha_Banner = BaseURL + Banner.Banner
        static let Lodjinha_Category = BaseURL + Category.Category
        
        static let Lodjinha_ProductByCategory = BaseURL + Product.ProductByCategory
        static let Lodjinha_ProductBestSeller = BaseURL + Product.ProductBestSeller
        static let Lodjinha_ProductById = BaseURL + Product.ProductById
        
    }
    
}

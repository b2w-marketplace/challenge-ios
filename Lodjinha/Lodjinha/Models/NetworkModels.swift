//
//  NetworkModels.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct Route<Model> {
    let endpoint: String
}

struct Routes {
    static let ProductById = Route<Product>(endpoint: "produto")

    static let Products = Route<ProductList>(endpoint: "produto")

    static let BestSellers = Route<BestSellers>(endpoint: "produto/maisvendidos")

    static let Categories = Route<CategoryList>(endpoint: "categoria")

    static let Banners = Route<BannerList>(endpoint: "banner")
}

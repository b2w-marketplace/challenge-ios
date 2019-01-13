//
//  ProductModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

public class ProductModel: ModelInterface {
    
    public var id: Int?
    public var name: String?
    public var urlImagem: String?
    public var description: String?
    public var priceOff: Float?
    public var salePrice: Float?
    public var category: CategoryModel?

    public required init() { }
    
    public init(id: Int?, name: String?, urlImagem: String?, description: String?, priceOff: Float?, salePrice: Float?, category: CategoryModel?) {
        self.id = id
        self.name = name
        self.urlImagem = urlImagem
        self.description = description
        self.priceOff = priceOff
        self.salePrice = salePrice
        self.category = category
    }
}

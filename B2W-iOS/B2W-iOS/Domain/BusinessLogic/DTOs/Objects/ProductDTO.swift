//
//  ProductDTO.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

struct ProductDTO: DTOInterface {
    typealias Model = ProductModel
    
    fileprivate enum Keys: String, CodingKey {
        case id
        case urlImagem
        case description = "descricao"
        case name = "nome"
        case priceOff = "precoDe"
        case salePrice = "precoPor"
        case category = "categoria"
    }
    
    var id: Int?
    var name: String?
    var urlImagem: String?
    var description: String?
    var priceOff: Float?
    var salePrice: Float?
    var category: CategoryDTO?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try? container.decode(Int.self, forKey: .id)
        urlImagem = try? container.decode(String.self, forKey: .urlImagem)
        description = try? container.decode(String.self, forKey: .description)
        name = try? container.decode(String.self, forKey: .name)
        priceOff = try? container.decode(Float.self, forKey: .priceOff)
        salePrice = try? container.decode(Float.self, forKey: .salePrice)
        category = try? container.decode(CategoryDTO.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(urlImagem, forKey: .urlImagem)
        try? container.encode(description, forKey: .description)
        try? container.encode(name, forKey: .name)
        try? container.encode(priceOff, forKey: .priceOff)
        try? container.encode(salePrice, forKey: .salePrice)
        try? container.encode(category, forKey: .category)
    }
    
    init(model: ProductModel?) {
        id = model?.id
        urlImagem = model?.urlImagem
        description = model?.description
        name = model?.name
        priceOff = model?.priceOff
        salePrice = model?.salePrice
        category = CategoryDTO(model: model?.category)
    }
    
    func parseToModel() -> ProductModel {
        let model: Model = Model(id: id,
                                 name: name,
                                 urlImagem: urlImagem,
                                 description: description,
                                 priceOff: priceOff,
                                 salePrice: salePrice,
                                 category: category?.parseToModel())
        return model
    }
}

//
//  CategoryDTO.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

struct CategoryDTO: DTOInterface {
    typealias Model = CategoryModel
    
    fileprivate enum Keys: String, CodingKey {
        case id
        case urlImagem
        case description = "descricao"
    }
    
    var id: Int?
    var urlImagem: String?
    var description: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try? container.decode(Int.self, forKey: .id)
        urlImagem = try? container.decode(String.self, forKey: .urlImagem)
        description = try? container.decode(String.self, forKey: .description)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(urlImagem, forKey: .urlImagem)
        try? container.encode(description, forKey: .description)
    }
    
    init(model: CategoryModel?) {
        id = model?.id
        urlImagem = model?.urlImagem
        description = model?.description
    }
    
    func parseToModel() -> CategoryModel {
        let model: Model = Model(id: id,
                                 urlImagem: urlImagem,
                                 description: description)
        return model
    }
}

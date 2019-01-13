//
//  GenericListDTO.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 26/09/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

struct GenericListDTO<T: DTOInterface>: DTOInterface {
    typealias Model = GenericListModel<T.Model>
    
    fileprivate enum Keys: String, CodingKey {
        case objects = "data"
        case offset
        case total
    }
    
    var objects: [T]?
    var offset: Int?
    var total: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        objects = try? container.decode([T].self, forKey: .objects)
        offset = try? container.decode(Int.self, forKey: .offset)
        total = try? container.decode(Int.self, forKey: .total)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try? container.encode(objects, forKey: .objects)
        try? container.encode(offset, forKey: .offset)
        try? container.encode(total, forKey: .total)
    }
    
    init(model: GenericListModel<T.Model>?) {
        objects = model?.objects?.compactMap({ T(model: $0) })
        offset = model?.offset
        total = model?.total
    }
    
    func parseToModel() -> GenericListModel<T.Model> {
        let model: Model = Model(objects: objects?.compactMap({ $0.parseToModel() }),
                                 offset: offset,
                                 total: total)
        return model
    }
}

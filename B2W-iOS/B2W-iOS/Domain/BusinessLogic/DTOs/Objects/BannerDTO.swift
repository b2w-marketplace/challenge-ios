//
//  BannerDTO.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

struct BannerDTO: DTOInterface {
    typealias Model = BannerModel
    
    var id: Int?
    var urlImagem: String?
    var linkUrl: String?
    
    init(model: BannerModel?) {
        id = model?.id
        urlImagem = model?.urlImagem
        linkUrl = model?.linkUrl
    }
    
    func parseToModel() -> BannerModel {
        let model: Model = Model(id: id,
                                 urlImagem: urlImagem,
                                 linkUrl: linkUrl)
        return model
    }
}

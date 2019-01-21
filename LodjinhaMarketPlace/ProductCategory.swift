//
//  ProductCategory.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ProductCategory {
    var id: Int?
    var descricao: String?
    var urlImagem: String?
    
    init(id: Int? = nil, descricao: String? = nil, urlImagem: String? = nil) {
        self.id = id
        self.descricao = descricao
        self.urlImagem = urlImagem
    }
}

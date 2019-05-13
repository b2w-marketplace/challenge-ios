//
//  Model.swift
//  ALojinha
//
//  Created by Arlen on 04/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK: Banner Info
class BannerAPIRequest: NSObject {
    var idBanner: Int = 0
    var urlImagemBanner: String = ""
    var linkUrlBanner: String = ""
    
    init(json: JSON) {
        idBanner = json["id"].intValue
        urlImagemBanner = json["urlImagem"].stringValue
        linkUrlBanner = json["linkUrl"].stringValue
    }
}

class CategoryAPIRequest: NSObject {
    var idCategory: Int = 0
    var descriptionCategory: String = ""
    var urlImagemCategory: String = ""
    
    init(json: JSON) {
        idCategory = json["id"].intValue
        descriptionCategory = json["descricao"].stringValue
        urlImagemCategory = json["urlImagem"].stringValue
    }
}

class ProductAPIRequest: NSObject {
    var idProduct: Int = 0
    var nameProduct: String = ""
    var urlImagemProduct: String = ""
    var descriptionProduct: String = ""
    var price1Product: Double = 0.0
    var price2Product: Double = 0.0
    var category: ProductCategoryAPIRequest
    
    init(json: JSON) {
        idProduct = json["id"].intValue
        nameProduct = json["nome"].stringValue
        urlImagemProduct = json["urlImagem"].stringValue
        descriptionProduct = json["descricao"].stringValue
        price1Product = json["precoDe"].doubleValue
        price2Product = json["precoPor"].doubleValue
        category = ProductCategoryAPIRequest(json: json["categoria"])
    }
}

class ProductCategoryAPIRequest: NSObject {
    var idCategory: Int = 0
    var descriptionCategory: String = ""
    var urlImagemCategory: String = ""
    
    init(json: JSON) {
        idCategory = json["id"].intValue
        descriptionCategory = json["descricao"].stringValue
        urlImagemCategory = json["urlImagem"].stringValue
    }
}

// MARK: Reserve Product Info
class ReserveAPIRequest: NSObject {
    var result: String = ""
    
    init(json: JSON) {
        result = json["result"].stringValue
    }
}

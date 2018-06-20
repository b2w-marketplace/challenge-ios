//
//  ProductModel.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import Gloss

class OffsetProductResponseModel: ProductResponseModel {
    
    let offset: Int!
    let total: Int!
    
    required init?(json: JSON) {
        guard let offset: Int = "offset" <~~ json,
            let total: Int = "total" <~~ json else {
                return nil
        }
        
        self.offset = offset
        self.total = total
        super.init(json: json)
    }
    
}

class ProductResponseModel: JSONDecodable {
    
    let products: [ProductModel]!
    
    required init?(json: JSON) {
        guard let products: [ProductModel] = "data" <~~ json else {
            return nil
        }
        self.products = products
    }
    
}

class ProductModel: JSONDecodable {
    
    let id: Int!
    let name: String!
    let imgUrl: String!
    let description: String!
    let originalPrice: Float!
    let discountPrice: Float?
    let category: CategoryModel!
    
    required init?(json: JSON) {
        guard let id: Int = "id" <~~ json,
            let name: String = "nome" <~~ json,
            let imgUrl: String = "urlImagem" <~~ json,
            let description: String = "descricao" <~~ json,
            let originalPrice: Float = "precoDe" <~~ json,
            let category: CategoryModel = "categoria" <~~ json else {
            return nil
        }
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.description = description
        self.originalPrice = originalPrice
        self.discountPrice = "precoPor" <~~ json
        self.category = category
    }
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func formattedAttributedOriginalPrice() -> NSAttributedString? {
        if let string = numberFormatter.string(from: NSNumber.init(value: self.originalPrice)) {
            let attString = NSAttributedString.init(string: string, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle])
            return attString
        }
        return nil
    }
    
    func formattedOriginalPrice() -> String? {
        return numberFormatter.string(from: NSNumber.init(value: self.originalPrice))
    }
    
    func formattedDiscountPrice() -> String? {
        if let discountPrice = self.discountPrice {
            return numberFormatter.string(from: NSNumber.init(value: discountPrice))
        }
        return nil
    }
    
}

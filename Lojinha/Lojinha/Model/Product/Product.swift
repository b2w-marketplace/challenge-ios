//
//  Product.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product: NSObject
{
    var id: Int
    var name: String
    var strDescription: String
    var image: ElementImage
    var priceOld: Double
    var priceNew: Double
    var category: Category
    
    override init()
    {
        id = 0
        name = ""
        strDescription = ""
        image = ElementImage()
        priceOld = 0
        priceNew = 0
        category = Category()
    }
    
    required init(dataJSON: JSON)
    {
        id = dataJSON["id"].intValue
        name = dataJSON["nome"].stringValue
        strDescription = dataJSON["descricao"].stringValue
        image = ElementImage(dataJSON: dataJSON["urlImagem"])
        priceOld = dataJSON["precoDe"].doubleValue
        priceNew = dataJSON["precoPor"].doubleValue
        category = Category(dataJSON: dataJSON["categoria"])
    }
}

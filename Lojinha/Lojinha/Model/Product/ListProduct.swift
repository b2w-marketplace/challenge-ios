//
//  ListProduct.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListProduct: NSObject
{
    var products: [Product]
    var offset: Int
    var total: Int
    
    override init()
    {
        products = [Product]()
        offset = 0
        total = 0
    }
    
    required convenience init(dataJSON: JSON)
    {
        self.init()
        offset = dataJSON["offset"].intValue
        total = dataJSON["total"].intValue
        parseJSON(arrayJson: dataJSON["data"].arrayValue)
    }
}


extension ListProduct: ListControl
{
    func parseJSON(arrayJson: [JSON])
    {
        for json in arrayJson
        {
            let product = Product(dataJSON: json)
            products.append(product)
        }
    }
}

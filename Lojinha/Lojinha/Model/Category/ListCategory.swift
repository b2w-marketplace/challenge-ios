//
//  ListCategory.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListCategory: NSObject
{
    var categories: [Category]
    
    override init()
    {
        categories = [Category]()
    }
    
    required convenience init(dataJSON: JSON)
    {
        self.init()
        parseJSON(arrayJson: dataJSON["data"].arrayValue)
    }
}


extension ListCategory: ListControl
{
    func parseJSON(arrayJson: [JSON])
    {
        for json in arrayJson
        {
            let category = Category(dataJSON: json)
            categories.append(category)
        }
    }
}

//
//  Category.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category: NSObject
{
    var id: Int
    var strDescription: String
    var image: ElementImage
    
    override init()
    {
        id = 0
        strDescription = ""
        image = ElementImage()
    }
    
    required init(dataJSON: JSON)
    {
        id = dataJSON["id"].intValue
        strDescription = dataJSON["descricao"].stringValue
        image = ElementImage(dataJSON: dataJSON)
    }
}

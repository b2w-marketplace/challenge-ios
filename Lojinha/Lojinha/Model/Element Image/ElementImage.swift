//
//  ElementImage.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class ElementImage: NSObject
{
    var urlImage: String
    
    override init()
    {
        urlImage = ""
    }
    
    required init(dataJSON: JSON)
    {
        urlImage = dataJSON["urlImagem"].stringValue
    }
}

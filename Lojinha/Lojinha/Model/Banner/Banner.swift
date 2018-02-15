//
//  Banner.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class Banner: NSObject
{
    var id: Int
    var linkURL: String
    var image: ElementImage
    
    override init()
    {
        id = 0
        linkURL = ""
        image = ElementImage()
    }
    required init(dataJSON: JSON)
    {
        id = dataJSON["id"].intValue
        linkURL = dataJSON["linkUrl"].stringValue
        image = ElementImage(dataJSON: dataJSON)
    }
}

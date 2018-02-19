//
//  ListBanner.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListBanner: NSObject
{
    var banners: [Banner]
    
    override init()
    {
        banners = [Banner]()
    }
    
    required convenience init(dataJSON: JSON)
    {
        self.init()
        parseJSON(arrayJson: dataJSON["data"].arrayValue)
    }
}


extension ListBanner: ListControl
{
    func parseJSON(arrayJson: [JSON])
    {
        for json in arrayJson
        {
            let banner = Banner(dataJSON: json)
            self.banners.append(banner)
        }
    }
}

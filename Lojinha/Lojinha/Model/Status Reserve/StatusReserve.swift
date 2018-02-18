//
//  StatusReserve.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 17/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class StatusReserve: NSObject
{
    var result: String
    var message: String
    
    override init()
    {
        result = ""
        message = ""
    }
    
    required init(dataJSON: JSON)
    {
        result = dataJSON["result"].stringValue
        message = dataJSON["message"].stringValue
    }
}

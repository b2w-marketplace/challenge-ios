//
//  Protocols.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol ListControl
{
    func parseJSON(arrayJson: [JSON])
}


protocol ListProtocol: class
{
    func numberOfRows() -> Int
}

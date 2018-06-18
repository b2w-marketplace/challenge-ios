//
//  Banner.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import SwiftyJSON

class Banner: NSObject {
    
    var id : Int = 0
    var linkUrl : String = ""
    var urlImagem : String = ""
    
    convenience init(dataJSON: JSON) {
        self.init()
        self.id = dataJSON["id"].intValue
        self.linkUrl = dataJSON["linkUrl"].stringValue
        self.urlImagem = dataJSON["urlImagem"].stringValue
    }
}

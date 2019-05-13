//
//  Model.swift
//  ALojinha
//
//  Created by Arlen on 04/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK: Banner Info
class BannerAPIRequest: NSObject {
    var id: Int = 0
    var urlImagem: String = ""
    var linkUrl: String = ""
    
    init(json: JSON) {
        id = json["id"].intValue
        urlImagem = json["urlImagem"].stringValue
        linkUrl = json["linkUrl"].stringValue
    }
}



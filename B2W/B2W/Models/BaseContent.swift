//
//  BaseContent.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class BaseContent: NSObject {
    var id: String?
    var urlImagem: String?
    
    init(data: NSDictionary){
        super.init()
        
        if let id = data.object(forKey: "id") {
            self.id = String(describing: id)
        }
        urlImagem = data.object(forKey: "urlImagem") as? String
    }
}

//
//  Banner.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class Banner: NSObject {
    var id: String?
    var urlImagem: String?
    var linkUrl: String?
    
    init(data: NSDictionary){
        super.init()
        
        if let id = data.object(forKey: "id") {
            self.id = String(describing: id)
        }
        self.urlImagem = data.object(forKey: "urlImagem") as? String
        self.linkUrl = data.object(forKey: "linkUrl") as? String
    }
}

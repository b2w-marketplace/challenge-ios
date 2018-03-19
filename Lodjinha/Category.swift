//
//  Category.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

struct Category: GenericObjectSerializable {

    var id: Int?
    var description: String?
    var imageUrl: String?
    
    init?(fromJSON json: NSDictionary?) {
        guard let json = json else {
            return
        }
        
        self.id = json["id"] as? Int
        self.description = json["descricao"] as? String
        self.imageUrl = json["urlImagem"] as? String
    }
}

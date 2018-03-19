//
//  Banner.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

struct Banner: GenericObjectSerializable{
    var id: Int?
    var linkUrl: String?
    var imageUrl: String?

    init?(fromJSON json: NSDictionary?) {
        guard let json = json else {
            return
        }
        self.id = json["id"] as? Int
        self.linkUrl = json["linkUrl"] as? String
        self.imageUrl = json["urlImagem"] as? String
    }
}

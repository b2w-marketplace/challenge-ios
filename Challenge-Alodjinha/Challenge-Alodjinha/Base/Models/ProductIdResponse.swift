//
//  ProductIdResponse.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct ProductIdResponse: Codable {
    var data: [Product]
    var offset: Int
    var total: Int
}

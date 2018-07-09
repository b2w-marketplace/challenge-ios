//
//  Banner.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

struct Banner: Codable {
    let id: Int
    let linkUrl: String
    let urlImagem: String
}

struct DataBanner:Codable{
    let data : [Banner]
}

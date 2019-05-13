//
//  Model.swift
//  ALojinha
//
//  Created by Arlen on 04/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation

// MARK: Banner Info
struct Banners: Equatable {
    var id: Int
    var urlImagem: String
    var linkUrl: String
}

func ==(lhs: Banners, rhs: Banners) -> Bool {
    return lhs.id == rhs.id
    && lhs.urlImagem == rhs.urlImagem
    && lhs.linkUrl == rhs.linkUrl
}

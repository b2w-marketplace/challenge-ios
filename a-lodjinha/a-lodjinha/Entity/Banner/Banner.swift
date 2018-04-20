//
//  Banner.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class Banner {
    
    public var id: Int
    public var linkUrl: String
    public var urlImagem: String

    init(id: Int,
         linkUrl: String,
         urlImagem: String) {
        
        self.id = id
        self.linkUrl = linkUrl
        self.urlImagem = urlImagem
        
    }
    
}

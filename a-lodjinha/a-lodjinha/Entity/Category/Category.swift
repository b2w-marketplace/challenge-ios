//
//  Category.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class Category {
    
    public var id: Int
    public var description: String
    public var urlImagem: String
    
    init(id: Int,
         description: String,
         urlImagem: String) {
        
        self.id = id
        self.description = description
        self.urlImagem = urlImagem
        
    }
    
}

//
//  Category.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import JSONJoy

class Category: JSONJoy
{
    let id: Int
    let description: String
    let urlImage: String
    
    init()
    {
        id = 0
        description = ""
        urlImage = ""
    }
    
    required init(_ decoder: JSONDecoder) throws
    {
        id = try decoder["id"].get()
        description = try decoder["descricao"].get()
        urlImage = try decoder["urlImagem"].get()
    }
}

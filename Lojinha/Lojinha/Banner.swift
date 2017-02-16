//
//  Banner.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import JSONJoy

class Banner: JSONJoy
{
    let id: Int
    let urlImage: String
    let linkUrl: String
    
    
    init()
    {
        id = 0
        urlImage = ""
        linkUrl = ""
    }
    
    required init(_ decoder: JSONDecoder) throws
    {
        id = try decoder["id"].get()
        urlImage = try decoder["urlImagem"].get()
        linkUrl = try decoder["linkUrl"].get()
    }
}

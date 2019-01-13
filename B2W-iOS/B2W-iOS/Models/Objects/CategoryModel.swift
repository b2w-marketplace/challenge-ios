//
//  CategoryModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

public class CategoryModel: ModelInterface {
    
    public var id: Int?
    public var urlImagem: String?
    public var description: String?
    
    public required init() { }
    
    public init(id: Int?, urlImagem: String?, description: String?) {
        self.id = id
        self.urlImagem = urlImagem
        self.description = description
    }
}

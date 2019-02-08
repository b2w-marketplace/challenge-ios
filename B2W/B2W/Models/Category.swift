//
//  Category.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class Category: BaseContent {
    var categoryDescription: String?
    
    override init(data: NSDictionary){
        super.init(data: data)
    
        categoryDescription = data.object(forKey: "descricao") as? String
    }

}

//
//  Banner.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class Banner: BaseContent {
    var linkUrl: String?
    
    override init(data: NSDictionary){
        super.init(data: data)
        
        linkUrl = data.object(forKey: "linkUrl") as? String
    }
}

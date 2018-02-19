//
//  GeneratorURL.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

struct GenerateURL
{
    static func get(type: TypeURL, offset: String? = nil) -> String
    {
        var url: String
        
        switch type
        {
        case .banner:
            url = APIAccess.url.rawValue + ExtensionURL.banner.rawValue
        
        case .category:
            url = APIAccess.url.rawValue + ExtensionURL.category.rawValue
            
        case .product, .reserveProduct:
            url = APIAccess.url.rawValue + ExtensionURL.product.rawValue + ComplementURL.bar.rawValue
            
        case .productByCategory:
            url = APIAccess.url.rawValue +
                ExtensionURL.product.rawValue +
                ComplementURL.offset.rawValue + (offset ?? "0") +
                ComplementURL.limit.rawValue +
                NumberOfProductsList.range.rawValue +
                ComplementURL.categoryID.rawValue
            
        case .topSellingProducts:
            url = APIAccess.url.rawValue + ExtensionURL.product.rawValue + ExtensionURL.topSellingProducts.rawValue
        }
        
        return url
    }
}

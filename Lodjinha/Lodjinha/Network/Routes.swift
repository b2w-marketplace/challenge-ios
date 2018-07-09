//
//  Routes.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

enum Routes{
    private var baseURL:String{
        return "https://alodjinha.herokuapp.com"
    }
    
    case banner
    case categoria
    case produto
    
    var endpoint:String{
        switch self {
            
        case .banner:
            return "\(baseURL)" + "/banner"
        case .categoria:
            return "\(baseURL)" + "/categoria"
        case .produto:
            return "\(baseURL)" + "/produto"
            
        }
    }
    
}

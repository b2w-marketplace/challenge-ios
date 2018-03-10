//
//  URLConstants.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import Foundation

struct APPURL {
    
    private  static let BaseURL = "https://alodjinha.herokuapp.com"
    
    static var GetBanners: String {
        return BaseURL  + "/banner"
    }
    static var GetCategories: String {
        return BaseURL + "/categoria"
    }
    static var GetProduto: String {
        return BaseURL + "/produto"
    }
    static var GetMaisVendidos: String {
        return BaseURL + "/produto/maisvendidos"
    }
}

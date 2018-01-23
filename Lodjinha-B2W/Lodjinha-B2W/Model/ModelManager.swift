//
//  ModelManager.swift
//  BRQ
//
//  Created by Fernanda de Lima on 24/08/17.
//  Copyright © 2017 BRQ. All rights reserved.
//
/* Uma classe singleton para gerenciar os models e deixa-los todos acessiveis para 
   manipular os dados que são gerados pelos endPoints*/

import UIKit

let mm = ModelManager.instance
class ModelManager: NSObject {
    
    //Singleton struct
    static let instance = ModelManager()
    
    //representaçoes das models
    var banner: InfoBanner?
    var categoria: InfoCategoria?
    var produto: InfoProduto?
    var maisVnedido: InfoProduto?
}

//
//  Repository.swift
//  GitHubAPI-Swift
//
//  Created by Matheus Fusco on 24/03/18.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product: NSObject {

    var categoria: Category!
    var descricao : String = ""
    var id : Int = 0
    var nome : String = ""
    var precoDe : Float = 0.0
    var precoPor : Float = 0.0
    var urlImagem : String = ""
    
    convenience init(dataJSON: JSON) {
        self.init()
        self.categoria = Category(dataJSON: dataJSON["categoria"])
        self.descricao = dataJSON["descricao"].stringValue
        self.id = dataJSON["id"].intValue
        self.nome = dataJSON["nome"].stringValue
        self.precoDe = dataJSON["precoDe"].floatValue
        self.precoPor = dataJSON["precoPor"].floatValue
        self.urlImagem = dataJSON["urlImagem"].stringValue
    }
}

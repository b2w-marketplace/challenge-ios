//
//  ProductViewModel.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation
class ProudctViewModel{
    var descriptionLabel: String
    var productImage: URL
    var priceLabel: String
    var titleProductLabel: String
    var discountPriceLabel: String
    var textProduct: NSAttributedString
    private var model:Produto
    var repository = ProductRepository()
    init(model:Produto) {
        self.model = model
        self.titleProductLabel = model.categoria.descricao
        self.descriptionLabel = model.nome
        self.productImage = URL(string:model.urlImagem)!
        self.priceLabel = "Por: \(model.precoPor)"
        self.discountPriceLabel = "De: \(model.precoDe)"
        self.titleProductLabel = model.nome
        self.textProduct = model.descricao.html2AttributedString!
    }
    
    func makeReservation(completionHandler:@escaping (Bool) -> Void){
        repository.makeReservation(itemId: "\(self.model.id)") { (status) in
            completionHandler(status)
        }
    }
}

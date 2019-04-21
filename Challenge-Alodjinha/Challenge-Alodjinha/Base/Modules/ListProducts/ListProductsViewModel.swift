//
//  ListProductsViewModel.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class ListProductsViewModel {
    
    private var category = [Category]()
    private var products = [Product]()
    
    var product: [Product] {
        return self.products
    }
    
    private weak var delegate: LoadContent?
    
    init(delegate: LoadContent?) {
        self.delegate = delegate
    }
    
    var transporterProducts: ResultTransporterProduct {
        return ResultTransporterProduct(product: products)
    }
    
    func setup(transporter: ResultTransporterCategory, index: Int) {
        self.category = [transporter.category[index]]
    }
    
    func listProductsLoad() {
        APIRequest().loadProduct(id: category[0].id) { response in
            if let response = response {
                self.products = response.data
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return products.count
    }
    
    func dtoForRow(index: Int) -> ProductCellDTO {
        let product = self.products[index]
        return ProductCellDTO(image: URL(string: product.urlImagem),
                              name: product.nome,
                              oldValue: product.precoDe,
                              newValue: product.precoPor)
    }
}

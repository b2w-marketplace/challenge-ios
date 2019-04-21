//
//  ListProductsViewModel.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class ListProductsViewModel {
    
    private var category = CategoryResponse()
    private var products = ProductIdResponse()
    
    var product: [Product] {
        return self.products.data
    }
    
    var categories: [Category] {
        return self.category.data
    }
    
    private weak var delegate: LoadContent?
    
    init(delegate: LoadContent?, category: CategoryResponse? = nil, product: ProductIdResponse? = nil) {
        self.delegate = delegate
        if let category = category {
            self.category = category
        }
        if let product = product {
            self.products = product
        }
    }
    
    var transporterProducts: ResultTransporterProduct {
        return ResultTransporterProduct(product: products.data)
    }
    
    func setup(transporter: ResultTransporterCategory, index: Int) {
        self.category.data = [transporter.category[index]]
    }
    
    func listProductsLoad() {
        APIRequest().loadProduct(id: category.data[0].id) { response in
            if let response = response {
                self.products.data = response.data
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return products.data.count
    }
    
    func dtoForRow(index: Int) -> ProductCellDTO {
        let product = self.products.data[index]
        return ProductCellDTO(image: URL(string: product.urlImagem),
                              name: product.nome,
                              oldValue: product.precoDe,
                              newValue: product.precoPor)
    }
}

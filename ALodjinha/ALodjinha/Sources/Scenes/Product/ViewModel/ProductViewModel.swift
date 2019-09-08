//
//  ProductViewModel.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class ProductViewModel {
    
    private var productResponse = ProductResponse()
    private var category: Category?
    private weak var delegate: LoadContentable?
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    
    init(delegate: LoadContentable?, product: ProductResponse? = nil) {
        self.delegate = delegate
        
        if let product = product {
            self.productResponse = product
        }
    }
    
    func setupInitial(category: Category) {
        self.category = category
    }
    
    func loadProduct() {
        guard !isLoading else { return }
        isLoading = true
        APIRequest().productRequest(id: self.category?.id ?? 0, offset: currentPage) { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                self.productResponse.data.append(contentsOf: response.data)
                self.currentPage += 1
            }
            self.delegate?.didLoad()
        }
        isLoading = false
    }
    
    func loadMore() {
        loadProduct()
    }
    
    func isLastIndex(indexPath: IndexPath) -> Bool {
        return (productResponse.data.count - 1) == indexPath.row
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.productResponse.data.count
    }
    
    func dtoForRows(indexPath: IndexPath) -> ProductCellDTO {
        let dto = productResponse.data[indexPath.row]
        return ProductCellDTO(name: dto.nome,
                              image: dto.urlImagem,
                              priceDe: dto.precoDe,
                              pricePor: dto.precoPor)
    }
    
    func productTransporter(indexPath: IndexPath) -> Product {
        return self.productResponse.data[indexPath.row]
    }
}

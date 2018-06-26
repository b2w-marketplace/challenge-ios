//
//  ProductsPresenter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

final class ProductsPresenter {
    
    private weak var delegate: ProductsPresentation?
    private let interactor: ProductsInteractor

    
    private var products: [Product] = [] {
        didSet {
            let productsViewModel = products.map(ProductViewModel.init)
            self.delegate?.onProducts(products: productsViewModel)
        }
    }
    
    init(delegate: ProductsPresentation, interactor: ProductsInteractor) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    func getProducts(idCategory: Int) {
        delegate?.onLoading()
        interactor.fetchProducts(idCategory: idCategory) { (result) in
            switch result {
            case .success(let products):
                self.products += products
            case .fail(let error):
                self.delegate?.onError(error: error)
            }
            self.delegate?.offLoading()
        }
    }
    
    func productIdIndex(index: Int) -> Int {
        return products[index].id
    }
}

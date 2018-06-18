//
//  HomePresenter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

final class HomePresenter {
    
    private weak var delegate: HomePresentation?
    private let interactor: HomeInteractor

    init(delegate: HomePresentation, interactor: HomeInteractor) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    func getCategories() {
        delegate?.onLoadingCategories()
        interactor.fetchCategories { (result) in
            switch result {
            case .success(let categories):
                self.delegate?.onCategories(categories: categories)
            case .fail(let error):
                self.delegate?.onErrorCategories(error: error)
            }
            self.delegate?.offLoadingCategories()
        }
    }
    
    func getProducts() {
        delegate?.onLoadingProducts()
        interactor.fetchProductsBestSeller { (result) in
            switch result {
            case .success(let products):
                self.delegate?.onProducts(products: products)
            case .fail(let error):
                self.delegate?.onErrorProducts(error: error)
            }
            self.delegate?.offLoadingProducts()
        }
        
    }
}

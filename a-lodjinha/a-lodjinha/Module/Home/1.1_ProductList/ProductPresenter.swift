//
//  ProductPresenter.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

protocol ProductPresenterDelegate: class {
    func showProducts(products: [Product])
    func showLoading(loading: Bool)
    func showConnectionError()
}

class ProductPresenter {
    
    weak var delegate: ProductPresenterDelegate?
    private var interactor: ProductInteractor
    private var router: ProductRouter
    
    //Initialize dependences here
    init(interactor: ProductInteractor, router: ProductRouter) {
        self.interactor = interactor
        self.router = router
    }

    func getBestSellers() {
        self.interactor.getBestSeller(success: { (products) in
            self.delegate?.showProducts(products: products)
            
        }) { (error) in
            print("Falha ao carregar produtos")
            self.delegate?.showConnectionError()
        }
    }
    
    func getProducts(categoryID: Int) {
        self.delegate?.showLoading(loading: true)
        self.interactor.getProduct( categoryID: categoryID,
                                    success: { (products) in
            
            self.delegate?.showProducts(products: products)
            self.delegate?.showLoading(loading: false)
            
        }) { (error) in
            print("Falha ao carregar produtos")
            self.delegate?.showLoading(loading: false)
            self.delegate?.showConnectionError()
        }
    }
    
    func callDetails(product: Product) {
        self.router.goToDetails(product: product)
    }
}

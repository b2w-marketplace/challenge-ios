//
//  HomePresenter.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: class {
    func showBanners(banners:[Banner])
    func showCategories(categories: [Category])
    func showLoading(loading: Bool)
    func showConnectionError()
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    private var interactor: HomeInteractor
    private var router: HomeRouter
    
    //Initialize dependences here
    init(interactor: HomeInteractor, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getBanners() {
        self.interactor.getBanners(success: { (banners) in
            
            self.delegate?.showBanners(banners: banners)
     
        }) { (error) in
            print("Falha ao carregar banners")
            self.delegate?.showConnectionError()
        }
    }
    
    func getCategories() {
        self.interactor.getCategory(success: { (categories) in
            self.delegate?.showCategories(categories: categories)
        }) { (error) in
            print("Falha ao carregar categorias")
            self.delegate?.showConnectionError()
        }
    }
    
    func callProductList(categoryID: Int,
                         categoryName: String) {
        self.router.goToProductList(categoryID: categoryID,
                                    categoryName: categoryName)
    }
    
    func callDetails(product: Product) {
        self.router.goToDetails(product: product)
    }

}

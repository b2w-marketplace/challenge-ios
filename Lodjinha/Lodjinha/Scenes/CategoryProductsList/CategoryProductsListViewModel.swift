//
//  CategoryProductsListViewModel.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol CategoryProductsListServicesDelegate: class {
    func receivedMoreData()
    func loadingData(loading: Bool)
}

protocol CategoryProductsListViewModelType {
    
    var products: [Product] { get set }
    var offset: Int { get set }
    var limit: Int { get set }
    var noMoreData: Bool { get set }
    
    var hasError: Bool { get set }
    var isLoadingData: Bool { get set }
    var numberOfSections: Int { get }
    func numberOfRowsInSection(section: Int) -> Int
    func loadProducts()
    func loadMore()
    func select(product: Product)
    
    var categoryProductsListServicesDelegate: CategoryProductsListServicesDelegate? { get set }
}

class CategoryProductsListViewModel: CategoryProductsListViewModelType {

    var products: [Product] = []
    var offset: Int = 0
    var limit: Int = 20
    var noMoreData: Bool = false
    
    var hasError: Bool = false
    var isLoadingData: Bool = false
    var numberOfSections: Int {
        return products.count != 0 ? 1 : 0
    }
    weak var categoryProductsListServicesDelegate: CategoryProductsListServicesDelegate?
    
    var service: CategoryProductsGateway!
    var category: ProductCategory
    var router: CategoriesRouterProtocol!
    
    init(service: CategoryProductsGateway, category: ProductCategory, router: CategoriesRouterProtocol) {
        self.service = service
        self.category = category
        self.router = router
    }
    
    func loadProducts() {
        categoryProductsListServicesDelegate?.loadingData(loading: true)
        isLoadingData = true
        
        service.loadProducts(forCategoryId: category.id, offset: offset, limit: limit) { [weak self] (result: Result<[Product]>) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.categoryProductsListServicesDelegate?.loadingData(loading: false)
            strongSelf.isLoadingData = false
            switch result {
            case .success(let products):
                strongSelf.products.append(contentsOf: products)
                strongSelf.offset = strongSelf.products.count
                strongSelf.categoryProductsListServicesDelegate?.receivedMoreData()
            case .failure(_):
                strongSelf.hasError = true
            }
        }
    }
    
    func loadMore() {
        isLoadingData = true
        
        service.loadProducts(forCategoryId: category.id, offset: offset, limit: limit) { [weak self] (result: Result<[Product]>) in
            guard let strongSelf = self else { return }
            strongSelf.isLoadingData = false
            
            switch result {
            case .success(let productsReceived):
                strongSelf.noMoreData = productsReceived.count == 0
                strongSelf.products.append(contentsOf: productsReceived)
                strongSelf.offset = strongSelf.products.count
                strongSelf.categoryProductsListServicesDelegate?.receivedMoreData()
            case .failure(_):
                strongSelf.hasError = true
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return products.count
    }
    
    func select(product: Product) {
        router.presentProductDetails(forProduct: product)
    }
    
}

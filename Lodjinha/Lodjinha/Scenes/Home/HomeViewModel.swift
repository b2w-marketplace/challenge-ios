//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

enum HomeSection {
    case categories
    case topSellingProducts
}

protocol HomeServicesDelegate: class {
    func finishLoadingHome()
    func loadingData(loading: Bool)
}

protocol HomeViewModelType {
    
    var banners: [Banner] { get set }
    var categories: [ProductCategory] { get set }
    var topSellingProducts: [Product] { get set }
    var homeSections: [HomeSection] { get }
    
    var hasError: Bool { get set }
    var numberOfSections: Int { get }
    func numberOfRowsInSection(section: HomeSection) -> Int
    
    func loadHome()
    func select(category: ProductCategory)
    func select(product: Product)
    
    var homeServicesDelegate: HomeServicesDelegate? { get set }
}

class HomeViewModel: HomeViewModelType {
    
    var banners: [Banner] = []
    var categories: [ProductCategory] = []
    var topSellingProducts: [Product] = []
    
    var hasError: Bool = false
    
    // Categories and TopSellingProducts sections
    var homeSections: [HomeSection] = [.categories, .topSellingProducts]
    
    var numberOfSections: Int {
        var sections = 0
        
        sections += categories.count > 0 ? 1 : 0
        sections += topSellingProducts.count > 0 ? 1 : 0
        if sections != homeSections.count {
            sections = 0
        }
        return sections
    }
    
    func numberOfRowsInSection(section: HomeSection) -> Int {
        switch section {
        case .categories:
            return 1
        case .topSellingProducts:
            return topSellingProducts.count
        }
    }
    
    weak var homeServicesDelegate: HomeServicesDelegate?
    
    var service: HomeServiceGateway!
    var router: HomeRouterProtocol
    init(service: HomeServiceGateway, router: HomeRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func loadHome() {
        homeServicesDelegate?.loadingData(loading: true)
        let group = DispatchGroup()
        group.enter()
        service.loadBanners { (result: Result<[Banner]>) in
            group.leave()
            switch result {
            case .success(let banners):
                self.banners = banners
            case .failure(_):
                self.hasError = true
            }
        }
        
        group.enter()
        service.loadCategories { (result: Result<[ProductCategory]>) in
            group.leave()
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(_):
                self.hasError = true
            }
        }
        
        group.enter()
        service.loadTopSellingProducts { (result: Result<[Product]>) in
            group.leave()
            switch result {
            case .success(let products):
                self.topSellingProducts = products
            case .failure(_):
                self.hasError = true
            }
        }
        
        group.notify(queue: .main) { [unowned self] in
            self.homeServicesDelegate?.loadingData(loading: false)
            self.homeServicesDelegate?.finishLoadingHome()
        }
        
    }
    
    func select(product: Product) {
        
    }
    
    func select(category: ProductCategory) {
        router.presentCategoryProducts(forCategory: category)
    }
}

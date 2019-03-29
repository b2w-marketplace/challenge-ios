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
//    func didLoadBanners()
//    func didLoadCategories()
//    func didLoadTopSellingProducts()
    func finishLoadingHome()
    func loadingData(loading: Bool)
}

protocol HomeViewModelType {
    
    var banners: [Banner] { get set }
    var categories: [ProductCategory] { get set }
    var topSellingProducts: [Product] { get set }
    var homeSections: [HomeSection] { get }
    var numberOfSections: Int { get }
    func numberOfRowsInSection(section: HomeSection) -> Int
    
    func loadHome()
    
    var homeServicesDelegate: HomeServicesDelegate? { get set }
}

class HomeViewModel: HomeViewModelType {
    
    var banners: [Banner] = []
    var categories: [ProductCategory] = []
    var topSellingProducts: [Product] = []
    
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
    init(service: HomeServiceGateway) {
        self.service = service
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
                self.banners = []
            }
        }
        
        group.enter()
        service.loadCategories { (result: Result<[ProductCategory]>) in
            group.leave()
            switch result {
            case .success(let categories):
                self.categories = categories
                break
            case .failure(_):
                break
            }
        }
        
        group.enter()
        service.loadTopSellingProducts { (result: Result<[Product]>) in
            group.leave()
            switch result {
            case .success(let products):
                self.topSellingProducts = products
                break
            case .failure(_):
                break
            }
        }
        
        group.notify(queue: .main) { [unowned self] in
            self.homeServicesDelegate?.loadingData(loading: false)
            self.homeServicesDelegate?.finishLoadingHome()
        }
        
    }
        
}

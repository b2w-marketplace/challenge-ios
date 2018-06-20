//
//  HomePresenter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

final class HomePresenter {
    
    private weak var delegate: HomePresentation?
    private let interactor: HomeInteractor
    private let router: HomeRouter
    
    private var banners: [Banner] = [] {
        didSet {
            let bannersViewModel = banners.map(BannerViewModel.init)
            self.delegate?.onBanners(banners: bannersViewModel)
        }
    }
    
    private var categories: [Category] = [] {
        didSet {
            let categoriesViewModel = categories.map(CategoryViewModel.init)
            self.delegate?.onCategories(categories: categoriesViewModel)
        }
    }

    
    private var products: [Product] = [] {
        didSet {
            let productsViewModel = products.map(ProductViewModel.init)
            self.delegate?.onProducts(products: productsViewModel)
        }
    }

    init(delegate: HomePresentation, interactor: HomeInteractor, router: HomeRouter) {
        self.delegate = delegate
        self.interactor = interactor
        self.router = router
    }
    
    func getCategories() {
        delegate?.onLoadingCategories()
        interactor.fetchCategories { (result) in
            switch result {
            case .success(let categories):
                self.categories = categories
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
                self.products = products
            case .fail(let error):
                self.delegate?.onErrorProducts(error: error)
            }
            self.delegate?.offLoadingProducts()
        }
    }
    
    func getBanners() {
        delegate?.onLoadingBanners()
        interactor.fetchBanners { (result) in
            switch result {
            case .success(let banners):
                self.banners = banners
            case .fail(let error):
                self.delegate?.onErrorBanners(error: error)
            }
            self.delegate?.offLoadingBanners()
        }
    }
    
    func showProduct(index: Int) {
        router.goToProductDetail(productId: products[index].id)
    }
    
    func showCategory(index: Int) {
        router.goToProducts(categoryId: categories[index].id)
    }

}

struct CategoryViewModel {
    let description: String
    let urlImage: URL
    
    init(category: Category) {
        self.description = category.description
        self.urlImage = category.urlImage
    }
}

struct ProductViewModel {
    let name: String
    let urlImage: URL
    let priceFrom: NSAttributedString
    let priceTo: String
    let description: String
    let categoryName: String
    
    init(product: Product) {
        self.name = product.name
        self.urlImage = product.urlImage
        self.priceFrom = NSAttributedString(
            string: String(format: "De %.2f", product.priceFrom),
            attributes: [
                NSAttributedStringKey.strikethroughStyle: 2
            ]
        )
        self.priceTo = String(format: "Por %.2f", product.priceFrom)
        self.description = product.description
        self.categoryName = product.category.description
    }
}

struct BannerViewModel {
    let urlImagem: URL
    let linkUrl: URL
    
    init(banner: Banner) {
        self.urlImagem = banner.urlImagem
        self.linkUrl = banner.linkUrl
    }
}

//
//  HomePresenter.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

protocol HomePresenterDelegate: class {
    func reloadCategories()
    func reloadProducts()
}

class HomePresenter: NSObject {
    private var categories = [CategoryModel]()
    private var mostSoldProd = [ProductModel]()
    
    weak var delegate: HomePresenterDelegate?
    
    override init() {
        super.init()
        self.fetchCategories()
        self.fetchMostSoldProducts()
    }
    
    private func fetchCategories() {
        LodjinhaAPI.getHomeCategories { (categories) in
            if let categoriesList = categories {
                self.categories = categoriesList
                self.delegate?.reloadCategories()
            }
        }
    }
    
    private func fetchMostSoldProducts() {
        LodjinhaAPI.getMostSoldProducts { (products) in
            if let productsList = products {
                self.mostSoldProd = productsList
                self.delegate?.reloadProducts()
            }
        }
    }
}

// MARK: - Categories
extension HomePresenter {
    var numberOfCategories: Int {
        return categories.count
    }
    
    func categoryInfo(atIndex index: IndexPath) -> (image: URL, name: String) {
        let category = self.categories[index.item]
        return (category.imageUrl, category.description)
    }
}

// MARK: - Products
extension HomePresenter {
    var mostSoldProductsNumber: Int {
        return mostSoldProd.count
    }
    
    func productInfo(atIndex index: IndexPath) -> (photo: URL, name: String, oldPrice: String, newPrice: String) {
        let product = self.mostSoldProd[index.item]
        return (product.imageUrl, product.name, "De \(product.oldPrice)", "Por \(product.newPrice)")
    }
}

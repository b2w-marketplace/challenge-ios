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
    
    func categoryId(forIndexPath index: IndexPath) -> Int {
        let category = self.categories[index.item]
        return category.id
    }
}

// MARK: - Products
extension HomePresenter {
    var mostSoldProductsNumber: Int {
        return mostSoldProd.count
    }
    
    func productInfo(atIndex index: IndexPath) -> (photo: URL, name: String, oldPrice: NSAttributedString, newPrice: String) {
        let product = self.mostSoldProd[index.item]
        
        let oldPriceText = String(format: "De %.2f", product.oldPrice)
        let oldPriceAttrString = NSAttributedString(string: oldPriceText, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        let newPriceString = String(format: "Por %.2f", product.newPrice)
        
        return (product.imageUrl, product.name, oldPriceAttrString, newPriceString)
    }
}

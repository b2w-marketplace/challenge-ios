//
//  CategoryPresenter.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 11/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

protocol CategoryPresenterDelegate: class {
    func reloadCategoryProducts()
}

class CategoryPresenter: NSObject {
    private var categoryId: Int?
    private var categoryProducts = [ProductModel]()
    private var totalProducts = 0
    
    weak var delegate: CategoryPresenterDelegate?
    
    func loadCategory(categoryId: Int) {
        self.categoryId = categoryId
        
        LodjinhaAPI.getCategoryProducts(categoryId: categoryId, limit: nil, offset: nil) {[weak self] (products, total) in
            if let categoryProducts = products {
                self?.categoryProducts = categoryProducts
                self?.totalProducts = total
                self?.delegate?.reloadCategoryProducts()
            }
        }
    }
}

// MARK: - Products
extension CategoryPresenter {
    var productsNumber: Int {
        return self.categoryProducts.count
    }
    
    func productInfo(atIndex index: IndexPath) -> (photo: URL, name: String, oldPrice: NSAttributedString, newPrice: String) {
        let product = self.categoryProducts[index.item]
        
        let oldPriceText = String(format: "De %.2f", product.oldPrice)
        let oldPriceAttrString = NSAttributedString(string: oldPriceText, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        let newPriceString = String(format: "Por %.2f", product.newPrice)
        
        return (product.imageUrl, product.name, oldPriceAttrString, newPriceString)
    }
}

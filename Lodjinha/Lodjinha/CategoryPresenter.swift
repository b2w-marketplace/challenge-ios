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
    private var loadingMoreItems = false
    
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
    
    private func loadMoreProductsIfNeeded(afterIndex index: Int) {
        guard !loadingMoreItems, self.categoryProducts.count < self.totalProducts else {
            return
        }
        
        // LoadMore Window
        let window = max(0, self.categoryProducts.count - 5)
        guard index > window, let categoryId = self.categoryId else {
            return
        }
        
        self.loadingMoreItems = true
        LodjinhaAPI.getCategoryProducts(categoryId: categoryId, limit: nil, offset: self.categoryProducts.count) {[weak self] (products, total) in
            self?.loadingMoreItems = false
            if let newProducts = products, !newProducts.isEmpty {
                self?.categoryProducts.append(contentsOf: newProducts)
                self?.totalProducts = total
                self?.delegate?.reloadCategoryProducts()
            }
            else {
                // API está retornando "total" inconsistent
                // Esta linha garante a parada do load more em caso de nao retornar mais resultados
                self?.totalProducts = self?.categoryProducts.count ?? 0
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
        self.loadMoreProductsIfNeeded(afterIndex: index.item)
        
        let product = self.categoryProducts[index.item]
        
        let oldPriceText = String(format: "De %.2f", product.oldPrice)
        let oldPriceAttrString = NSAttributedString(string: oldPriceText, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        let newPriceString = String(format: "Por %.2f", product.newPrice)
        
        return (product.imageUrl, product.name, oldPriceAttrString, newPriceString)
    }
    
    func productAtIndex(indexPath: IndexPath) -> ProductModel {
        return self.categoryProducts[indexPath.row]
    }
}

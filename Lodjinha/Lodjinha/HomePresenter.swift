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
}

class HomePresenter: NSObject {
    private var categories = [CategoryModel]()
    
    weak var delegate: HomePresenterDelegate?
    
    override init() {
        super.init()
        self.fetchCategories()
    }
    
    private func fetchCategories() {
        LodjinhaAPI.getHomeCategories { (categories) in
            if let categoriesList = categories {
                self.categories = categoriesList
                self.delegate?.reloadCategories()
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

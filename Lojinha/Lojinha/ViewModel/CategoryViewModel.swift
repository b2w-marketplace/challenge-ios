//
//  CategoryViewModel.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

protocol CategoryViewModelProtocol: ListProtocol
{
    var list: ListCategory? { get }
    var listCategoryDidChange: ((CategoryViewModelProtocol) -> Void)? { get set }    
}

class CategoryViewModel: CategoryViewModelProtocol
{
    var list: ListCategory?
    {
        didSet
        {
            self.listCategoryDidChange?(self)
        }
    }
    
    var listCategoryDidChange: ((CategoryViewModelProtocol) -> Void)?
    
    required init()
    {
        list = ListCategory()
    }
    
    func numberOfRows() -> Int
    {
        return list?.categories.count ?? 0
    }
}

extension CategoryViewModel
{
    func getElement(completion: @escaping (Error?) -> Void)
    {
        let url = GenerateURL.get(type: .category)
        CategoryManager.getCategory(withURL: url) { (categories, error) in
            if let list = categories
            {
                self.list = list
            }
            if let error = error
            {
                completion(error)
            }
        }
    }
}

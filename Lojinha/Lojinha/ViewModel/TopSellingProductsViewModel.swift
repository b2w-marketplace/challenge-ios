//
//  TopSellingProductsViewModel.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

protocol TopSellingProductsViewModelProtocol: ListProtocol
{
    var list: ListProduct? { get }
    var listTopSellingProductsDidChange: ((TopSellingProductsViewModelProtocol) -> Void)? { get set }
}

class TopSellingProductsViewModel: TopSellingProductsViewModelProtocol
{
    var list: ListProduct?
    {
        didSet
        {
            self.listTopSellingProductsDidChange?(self)
        }
    }
    
    var listTopSellingProductsDidChange: ((TopSellingProductsViewModelProtocol) -> Void)?
    
    required init()
    {
        list = ListProduct()
    }
    
    func numberOfRows() -> Int
    {
        return list?.products.count ?? 0
    }
}

extension TopSellingProductsViewModel
{
    func getElement(completion: @escaping (Error?) -> Void)
    {
        let url = GenerateURL.get(type: .topSellingProducts)
        ProductManager.getProducts(withURL: url) { (products, error) in
            if let list = products
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

//
//  ProductViewModel.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

protocol ProductViewModelProtocol: ListParamURLProtocol
{
    var list: ListProduct? { get }
    var listProductDidChange: ((ProductViewModelProtocol) -> Void)? { get set }
}

class ProductViewMode: ProductViewModelProtocol
{
    var list: ListProduct?
    {
        didSet
        {
            self.listProductDidChange?(self)
        }
    }
    
    var listProductDidChange: ((ProductViewModelProtocol) -> Void)?
    
    required init()
    {
        list = ListProduct()
    }
    
    
    func numberOfRows() -> Int
    {
        return list?.products.count ?? 0
    }
}

extension ProductViewMode
{
    func getElement(withURL url: String, completion: @escaping (Error?) -> Void)
    {
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

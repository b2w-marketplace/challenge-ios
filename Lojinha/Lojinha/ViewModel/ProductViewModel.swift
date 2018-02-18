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
    
    func add(products: ListProduct)
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
    
    func add(products: ListProduct)
    {
        let tempProducts = list
        tempProducts?.products += products.products
        list = tempProducts
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
    
    func addProductToReserve(productID: Int, completion: @escaping (StatusReserve?, Error?) -> Void)
    {
        let url = GenerateURL.get(type: .reserveProduct) + String(productID)
        ProductManager.postProduct(withURL: url) { (status, error) in
            if let status = status
            {
                completion(status, nil)
            }
            if let error = error
            {
                completion(nil, error)
            }
        }
    }
}

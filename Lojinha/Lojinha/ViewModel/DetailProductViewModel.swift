//
//  DetailProductViewModel.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

protocol DetailProductViewModelProtocol: SingleElement
{
    var product: Product? { get }
    var productDidChange: ((DetailProductViewModelProtocol) -> Void)? { get set }
    
    func addProductToReserve(productID: Int, completion: @escaping(StatusReserve?, Error?) -> Void)
}

class DetailProductViewModel: DetailProductViewModelProtocol
{
    var product: Product?
    {
        didSet
        {
            self.productDidChange?(self)
        }
    }
    
    var productDidChange: ((DetailProductViewModelProtocol) -> Void)?
    
    required init()
    {
        product = Product()
    }
    
    
}


extension DetailProductViewModel
{
    func getElement(withURL url: String, completion: @escaping (Error?) -> Void)
    {
        ProductManager.getProduct(withURL: url) { (product, error) in
            if let product = product
            {
                self.product = product
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
            else if let error = error
            {
                completion(nil, error)
            }
        }
    }
}

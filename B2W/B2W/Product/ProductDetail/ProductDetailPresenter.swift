//
//  ProductDetailPresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class ProductDetailPresenter: NSObject, ProductDetailDelegate {
    let productDetail = ProductDetailVC(nibName: "ProductDetailVC", bundle: Bundle.main)
    let productDetailInteractor = ProductDetailInteractor()
    var product: Product?
    
    func registerDelegate(){
        productDetail.delegate = self
    }
    
    func didLoad(){
        productDetail.bind(product: product)
    }
    
    func bookAction() {
        if let id = product?.id{
            productDetailInteractor.bookProduct(productId: "200") {
                self.productDetail.navigationController?.popViewController(animated: true)
            }
        }
    }
}

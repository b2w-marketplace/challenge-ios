//
//  ProductsViewModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ProductsViewModel {
    
    let products = BehaviorRelay<[Products]>(value: [])
    let offset = BehaviorRelay<Int>(value: 1)
    let category = BehaviorRelay<Int>(value: 1)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String>(value: "")

    func getProducts() {
        
        isLoading.accept(true)
        errorMsg.accept("")
        
        LodjinhaAPIManager.shared.productsByCategory(byOffset: offset.value, andCategory: category.value, failure: { (error) in
            self.isLoading.accept(false)
            self.errorMsg.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let products = result?.data {
                self.products.accept(products)
            }
            self.isLoading.accept(false)
        }
    }
    
}

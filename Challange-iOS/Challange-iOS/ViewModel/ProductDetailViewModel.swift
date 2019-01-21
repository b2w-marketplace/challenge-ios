//
//  ProductDetailViewModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 21/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Kingfisher


class ProductDetailViewModel {
    
    let product = BehaviorRelay<Products?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String>(value: "")
    let resultMessage = BehaviorRelay<String>(value: "")
    let isSuccess = BehaviorRelay<Bool>(value: false)
    
    func getProduct(byID productID: Int) {
        
        isLoading.accept(true)
        errorMsg.accept("")
        
        LodjinhaAPIManager.shared.product(byId: productID, failure: { (error) in
            self.isLoading.accept(false)
            self.errorMsg.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let product = result {
                self.product.accept(product)
            }
            self.isLoading.accept(false)
        }
    }
    
    func bookProduct(productID: Int) {
        
        isLoading.accept(true)
        errorMsg.accept("")
        
        LodjinhaAPIManager.shared.bookProduct(byId: productID, failure: { (error) in
            self.isLoading.accept(false)
            self.errorMsg.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let resultMessage = result?.result {
                if resultMessage == "success" {
                    self.resultMessage.accept("Livro reservado com sucesso")
                    self.isSuccess.accept(true)
                } else {
                     self.resultMessage.accept("Não foi possível reservar o livro")
                }
            }
            self.isLoading.accept(false)
        }
    }
    
}

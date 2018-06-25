//
//  ProductViewControllerMock.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 25/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

@testable import desafiob2w
class ProductViewControllerMock: ProductPresentation {
    
    var calledOnLoading: Bool!
    var calledOffLoading: Bool!
    var calledOnError: NetworkError!
    var calledOnProduct: ProductViewModel!
    var calledOnReserved: String!
    
    func onLoading() {
        calledOnLoading = true
    }
    
    func offLoading() {
        calledOffLoading = true
    }
    
    func onError(error: NetworkError) {
        calledOnError = error
    }
    
    func onProduct(product: ProductViewModel) {
        calledOnProduct = product
    }
    
    func onReserved(message: String, isSuccess: Bool) {
        calledOnReserved = message
    }

}

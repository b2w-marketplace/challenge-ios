//
//  ProductPresentation.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

protocol ProductPresentation: class {
    func onLoading()
    func offLoading()
    func onError(error: NetworkError)
    func onProduct(product: ProductViewModel)
    func onReserved(message: String, isSuccess: Bool)
    
}

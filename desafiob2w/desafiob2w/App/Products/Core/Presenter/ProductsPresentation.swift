//
//  ProductsPresentation.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

protocol ProductsPresentation: class {
    func onLoading()
    func offLoading()
    func onError(error: NetworkError)
    func onProducts(products: [ProductViewModel])
}

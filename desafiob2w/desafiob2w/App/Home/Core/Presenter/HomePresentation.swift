//
//  HomePresentation.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

protocol HomePresentation: class {
    func onLoadingCategories()
    func offLoadingCategories()
    func offLoadingProducts()
    func onLoadingProducts()
    func onErrorCategories(error: NetworkError)
    func onErrorProducts(error: NetworkError)
    func onCategories(categories: [Category])
    func onProducts(products: [Product])
}

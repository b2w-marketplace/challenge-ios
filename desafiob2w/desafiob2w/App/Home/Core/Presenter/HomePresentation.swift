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
    func onLoadingProducts()
    func offLoadingProducts()
    func onLoadingBanners()
    func offLoadingBanners()
    func onErrorCategories(error: NetworkError)
    func onErrorProducts(error: NetworkError)
    func onErrorBanners(error: NetworkError)
    func onCategories(categories: [CategoryViewModel])
    func onProducts(products: [ProductViewModel])
    func onBanners(banners: [BannerViewModel])
}

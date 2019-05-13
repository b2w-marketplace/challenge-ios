//
//  ProductWorker.swift
//  ALojinha
//
//  Created by Arlen on 04/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation

class ProductWorker {
    var productStore: ProductStoreProtocol
    init(productStore: ProductStoreProtocol) {
        self.productStore = productStore
    }
    
    func fetchBanners(completionHandler: @escaping ([BannerAPIRequest]) -> Void) {
        productStore.fetchBanners { (banners: () throws -> [BannerAPIRequest]) -> Void in
            do {
                let banners = try banners()
                DispatchQueue.main.async {
                    completionHandler(banners)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchCategories(completionHandler: @escaping ([CategoryAPIRequest]) -> Void) {
        productStore.fetchCategories { (categories: () throws -> [CategoryAPIRequest]) -> Void in
            do {
                let categories = try categories()
                DispatchQueue.main.async {
                    completionHandler(categories)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchBestSellers(completionHandler: @escaping ([ProductAPIRequest]) -> Void) {
        productStore.fetchBestSellers { (bestSellers: () throws -> [ProductAPIRequest]) -> Void in
            do {
                let bestSellers = try bestSellers()
                DispatchQueue.main.async {
                    completionHandler(bestSellers)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchProductList(completionHandler: @escaping ([ProductAPIRequest]) -> Void) {
        productStore.fetchProductList { (products: () throws -> [ProductAPIRequest]) -> Void in
            do {
                let products = try products()
                DispatchQueue.main.async {
                    completionHandler(products)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func makeReserve(idProduct: Int, completionHandler: @escaping ([ReserveAPIRequest]) -> Void) {
        productStore.makeReserve(idProduct: idProduct) { (result: () throws -> [ReserveAPIRequest]) -> Void in
            do {
                let result = try result()
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
}

protocol ProductStoreProtocol {
    func fetchBanners(completionHandler: @escaping (() throws -> [BannerAPIRequest]) -> Void)
    func fetchCategories(completionHandler: @escaping (() throws ->[CategoryAPIRequest]) -> Void)
    func fetchBestSellers(completionHandler: @escaping (() throws ->[ProductAPIRequest]) -> Void)
    func fetchProductList(completionHandler: @escaping (() throws ->[ProductAPIRequest]) -> Void)
    func makeReserve(idProduct: Int, completionHandler: @escaping (() throws ->[ReserveAPIRequest]) -> Void)
}

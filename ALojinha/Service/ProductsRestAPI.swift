//
//  ProductsRestAPI.swift
//  ALojinha
//
//  Created by Arlen on 04/05/19.
//  Copyright © 2019 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductsRestAPI: ProductStoreProtocol {
    
    let errorMessage = "message"
    
    //MARK: - CRUD opertions
    func fetchBanners(completionHandler: @escaping (() throws -> [BannerAPIRequest]) -> Void) {
        let bannerHttp = "https://alodjinha.herokuapp.com/banner"
        
        Alamofire.request(bannerHttp).responseJSON { (responseData) -> Void in
            guard responseData.error == nil else {
                let error = responseData.error! as NSError
                print("**** Error (Banners) **** ", error)
                return
            }
            
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                guard !swiftyJsonVar[self.errorMessage].exists() else {
                    let message = swiftyJsonVar[self.errorMessage].stringValue
                    print("*** Fail Response (Banners) ***", message)
                    return
                }
                var banners = [BannerAPIRequest]()
                for(_, item):(String, JSON) in swiftyJsonVar {
                    for count in 0...item.count {
                        let banner = BannerAPIRequest(json: item[count])
                        banners.append(banner)
                    }
                }
                completionHandler { banners }
            }
        }
    }
    
    func fetchCategories(completionHandler: @escaping (() throws -> [CategoryAPIRequest]) -> Void) {
        let categoryHttp = "https://alodjinha.herokuapp.com/categoria"
        
        Alamofire.request(categoryHttp).responseJSON { (responseData) -> Void in
            guard responseData.error == nil else {
                let error = responseData.error! as NSError
                print("**** Error (Categories) **** ", error)
                return
            }
            
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                guard !swiftyJsonVar[self.errorMessage].exists() else {
                    let message = swiftyJsonVar[self.errorMessage].stringValue
                    print("*** Fail Response (Categories) ***", message)
                    return
                }
                var categories = [CategoryAPIRequest]()
                for(_, item):(String, JSON) in swiftyJsonVar {
                    for count in 0...item.count {
                        let category = CategoryAPIRequest(json: item[count])
                        categories.append(category)
                    }
                }
                completionHandler { categories }
            }
        }
    }
    
    func fetchBestSellers(completionHandler: @escaping (() throws -> [ProductAPIRequest]) -> Void) {
        let bestSellersHttp = "https://alodjinha.herokuapp.com/produto/maisvendidos"
        
        Alamofire.request(bestSellersHttp).responseJSON { (responseData) -> Void in
            guard responseData.error == nil else {
                let error = responseData.error! as NSError
                print("**** Error (Best Sellers) **** ", error)
                return
            }
            
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                guard !swiftyJsonVar[self.errorMessage].exists() else {
                    let message = swiftyJsonVar[self.errorMessage].stringValue
                    print("*** Fail Response (Best Sellers) ***", message)
                    return
                }
                
                var bestSellers = [ProductAPIRequest]()
                for(_, item):(String, JSON) in swiftyJsonVar {
                    for count in 0...item.count {
                        let bestSeller = ProductAPIRequest(json: item[count])
                        bestSellers.append(bestSeller)
                    }
                }
                completionHandler { bestSellers }
            }
        }
    }
    
    func fetchProductList(completionHandler: @escaping (() throws -> [ProductAPIRequest]) -> Void) {
        let productsHttp = "https://alodjinha.herokuapp.com/produto"
        
        Alamofire.request(productsHttp).responseJSON { (responseData) -> Void in
            guard responseData.error == nil else {
                let error = responseData.error! as NSError
                print("**** Error (Products) **** ", error)
                return
            }
            
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                guard !swiftyJsonVar[self.errorMessage].exists() else {
                    let message = swiftyJsonVar[self.errorMessage].stringValue
                    print("*** Fail Response (Products) ***", message)
                    return
                }
                
                var productList = [ProductAPIRequest]()
                for(key, item):(String, JSON) in swiftyJsonVar {
                    if key == "data" {
                        for count in 0...item.count {
                            print(item[count])
                            let productUnit = ProductAPIRequest(json: item[count])
                            productList.append(productUnit)
                        }
                    }
                }
                completionHandler { productList }
            }
        }
    }
    func makeReserve(idProduct: Int, completionHandler: @escaping (() throws -> [ReserveAPIRequest]) -> Void) {
        let makeReserveHttp = "https://alodjinha.herokuapp.com/produto/\(idProduct)"
        
        Alamofire.request(makeReserveHttp, method: .post).responseJSON { (responseData) -> Void in
            guard responseData.error == nil else {
                let error = responseData.error! as NSError
                print("**** Error (Make Reserve Product) **** ", error)
                return
            }
            
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                guard !swiftyJsonVar[self.errorMessage].exists() else {
                    let message = swiftyJsonVar[self.errorMessage].stringValue
                    print("*** Fail Response (Make Reserve Product) ***", message)
                    return
                }
                var results = [ReserveAPIRequest]()
                results.append(ReserveAPIRequest(json: swiftyJsonVar))
                completionHandler { results }
            }
        }
    }
}

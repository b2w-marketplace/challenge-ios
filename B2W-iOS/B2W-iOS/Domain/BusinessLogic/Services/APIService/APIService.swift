//
//  APIService.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 23/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation
import Alamofire

public struct APIService: LodjinhaAPIInterface {
    
    func getBanner(completionHandler: @escaping (Result<GenericListModel<BannerModel>>) -> Void) {
        let request: LodjinhaRequests = .getBanners
        ServiceEngine.performRequest(route: request) { (result: Result<GenericListDTO<BannerDTO>>) in
            switch result {
            case .success(let value):
                completionHandler(.success(value.parseToModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCategories(completionHandler: @escaping (Result<GenericListModel<CategoryModel>>) -> Void) {
        let request: LodjinhaRequests = .getProductCategories
        ServiceEngine.performRequest(route: request) { (result: Result<GenericListDTO<CategoryDTO>>) in
            switch result {
            case .success(let value):
                completionHandler(.success(value.parseToModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBestSellers(completionHandler: @escaping (Result<GenericListModel<ProductModel>>) -> Void) {
        let request: LodjinhaRequests = .getBestSellers
        ServiceEngine.performRequest(route: request) { (result: Result<GenericListDTO<ProductDTO>>) in
            switch result {
            case .success(let value):
                completionHandler(.success(value.parseToModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getProductsByCategory(id: Int, offset: Int, completionHandler: @escaping (Result<GenericListModel<ProductModel>>) -> Void) {
        let request: LodjinhaRequests = .getProductByCategory(id: id, offset: offset)
        ServiceEngine.performRequest(route: request) { (result: Result<GenericListDTO<ProductDTO>>) in
            switch result {
            case .success(let value):
                completionHandler(.success(value.parseToModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func postReserveProduct(id: Int, completionHandler: @escaping (Result<ResultModel>) -> Void) {
        let request: LodjinhaRequests = .postReserveProduct(id: id)
        ServiceEngine.performRequest(route: request) { (result: Result<ResultDTO>) in
            switch result {
            case .success(let value):
                completionHandler(.success(value.parseToModel()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

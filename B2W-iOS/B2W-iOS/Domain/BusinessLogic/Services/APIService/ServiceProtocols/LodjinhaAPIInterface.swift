//
//  LodjinhaAPIInterface.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 23/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation
import Alamofire

internal protocol LodjinhaAPIInterface {
    func getBanner(completionHandler: @escaping (Result<GenericListModel<BannerModel>>) -> Void)
    func getCategories(completionHandler: @escaping (Result<GenericListModel<CategoryModel>>) -> Void)
    func getBestSellers(completionHandler: @escaping (Result<GenericListModel<ProductModel>>) -> Void)
    func getProductsByCategory(id: Int, offset: Int, completionHandler: @escaping (Result<GenericListModel<ProductModel>>) -> Void)
    func postReserveProduct(id: Int, completionHandler: @escaping (Result<ResultModel>) -> Void)
}

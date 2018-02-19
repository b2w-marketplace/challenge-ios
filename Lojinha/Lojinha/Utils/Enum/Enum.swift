//
//  Enum.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import UIKit


enum TypeURL
{
    case banner
    case category
    case product
    case productByCategory
    case topSellingProducts
    case reserveProduct
}


enum APIAccess: String
{
    case url = "https://alodjinha.herokuapp.com/"
}


enum NumberOfProductsList: String
{
    case range = "20"
}


enum ExtensionURL: String
{
    case banner = "banner"
    case category = "categoria"
    case product = "produto"
    case topSellingProducts = "/maisvendidos"
}

enum ComplementURL: String
{
    case bar = "/"
    case offset = "?offset="
    case limit = "&limit="
    case categoryID = "&categoriaId="
}


enum ErrorType
{
    case unknown
    case alamofire
}


enum Corner: CGFloat
{
    case button = 5
}


enum Status: String
{
    case success = "success"
    case error = "error"
}

enum NotificationName: String
{
    case popView = "popViewControllerNotificationCenter"
}

enum CellIdentifier: String
{
    case listHome = "listHomeCell"
    case bannerHome = "bannerHomeCell"
    case listCatetoryHome = "listCategoryHome"
    
    case bannerCell = "bannerCell"
    case categoryCell = "categoryCell"
    
    case categoryListCell = "categoryListCell"
    
}


enum RestorationID: String
{
    case bannerHome = "bannerHomeCollectionView"
}


enum Segue: String
{
    case detailCategory = "detailCategorySegue"
    case detailProduct = "productDetailSegue"
}

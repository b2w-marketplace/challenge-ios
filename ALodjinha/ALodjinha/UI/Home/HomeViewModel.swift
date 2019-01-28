//
//  HomeViewModel.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 25/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: NSObject {
    
    var bannerArray = BehaviorRelay<[BannerModel]>(value: [])
    var categoryArray = BehaviorRelay<[CategoryModel]>(value: [])
    var bestSellerArray = BehaviorRelay<[ProductModel]>(value: [])
    
    override init() {
        super.init()
        
        getData()
    }
    
    func getData() {
        
        BannerAPI.shared.getBanners { [weak self] (bannerArray) in
            self?.bannerArray.accept(bannerArray)
        }
        
        CategoryAPI.shared.getCategories { [weak self] (categoryArray) in
            self?.categoryArray.accept(categoryArray)
        }
        
        ProductAPI.shared.getBestSellers { [weak self] (productArray) in
            self?.bestSellerArray.accept(productArray)
        }
        
    }

}

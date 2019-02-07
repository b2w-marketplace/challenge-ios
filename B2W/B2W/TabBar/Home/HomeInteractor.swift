//
//  HomeInteractor.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {
    var currentTask: Array<URLSessionTask> = []
    var complitionHomeContent: (() -> ())?
    var bannerList: Array<Banner> = []
    var categoryList: Array<Category> = []
    var productList: Array<Product> = []
    let totalOfRequests = 3
    var finishedRequests = 0
    let loading = LoadingPresenter()
    
    func getBannerList(successHandler: @escaping (_ responseObject: Array<Banner>?) -> ()){
        BannerClient().getBannerList(successHandler: { bannerList in
            successHandler(bannerList)
        }) { error, isCancelled in
            //Handler banner error
        }
    }
    
    func getCategoryList(successHandler: @escaping (_ responseObject: Array<Category>?) -> ()){
        CategoryClient().getCategoryList(successHandler: { categoryList in
            successHandler(categoryList)
        }) { error, isCancelled in
            //Handler category error
        }
    }
    
    func getProductList(successHandler: @escaping (_ responseObject: Array<Product>?) -> ()){
        ProductClient().getBestSellerProducts(successHandler: { productList in
            successHandler(productList)
        }) { error, isCancelled in
            //Handler product error
        }
    }
    
    func loadHomeContent(complitionHomeContent: @escaping () -> ()){
        loading.showLoading()
        
        self.complitionHomeContent = complitionHomeContent
        
        self.getBannerList(successHandler: { bannerList in
            self.bannerList = bannerList!
            self.checkComplitionHomeContent()
        })
        
        self.getCategoryList(successHandler: { categoryList in
            self.categoryList = categoryList!
            self.checkComplitionHomeContent()
        })
        
        self.getProductList(successHandler: { productList in
            self.productList = productList!
            self.checkComplitionHomeContent()
        })
    }
    
    func checkComplitionHomeContent(){
        finishedRequests = finishedRequests + 1
        
        if finishedRequests == totalOfRequests{
            loading.hideLoading()
            self.complitionHomeContent?()
        }
    }
}

//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

class HomeViewModel{
    private var banners = [BannerViewModel]()
    private var categories = [CategoryViewModel]()
    private var bestSellers = [BestSellerViewModel]()

    private var repository = HomeRepository()
    
    var numberOfBanners :Int {
        return banners.count
    }
    
    var listBannerOfItems:[BannerViewModel]{
        return self.banners
    }
    
    var numberOfCategories :Int {
        return categories.count
    }
    
    var listCategoryOfItems:[CategoryViewModel]{
        return self.categories
    }
    
    var numberOfBestSellers :Int {
        return bestSellers.count
    }
    
    var listBestSellerItems:[BestSellerViewModel]{
        return self.bestSellers
    }
    
    func loadBanners(completion :@escaping  ()->Void){
        repository.getBannerList { (bannerList) in
            self.banners = bannerList.map{BannerViewModel(model: $0)}
            dump(bannerList)
            completion()
        }
    }
    
    func loadCategories(completion :@escaping  ()->Void){
        repository.getCategoryList { (categoryList) in
            self.categories = categoryList.map{CategoryViewModel(model: $0)}
            dump(categoryList)
            completion()
        }
    }
    
    func loadBestSellers(completion :@escaping  ()->Void){
        repository.getBestSellersList { (bestSellerList) in
            self.bestSellers = bestSellerList.map{BestSellerViewModel(model: $0)}
            dump(bestSellerList)
            completion()
        }
    }
    
    func getBannerAtIndex(index:Int)->BannerViewModel{
        return banners[index]
    }
    
    func getCategoriesAtIndex(index:Int)->CategoryViewModel{
        return categories[index]
    }
    
    func getProductAtIndex(index:Int)->Produto{
        return bestSellers[index].model
    }
    
    
    
    
}
